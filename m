Return-Path: <linux-kernel+bounces-805604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7DFB48AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A94D3A59D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C5E2F0C51;
	Mon,  8 Sep 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQISXu3j"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083636B;
	Mon,  8 Sep 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329299; cv=none; b=V6DvsVB2jNtWcUeo9PX15cvYDOhzdlPurzkn1QZEdrcRWei4ksQif6Vst38wxannPoUPn2R6rySEEI/kHW3wOknlgbEvs9K6WeTukqO8/KIxGmDEpCIAw2Cn7F+RPNtMWZeSjYkrvm7PS2JZWVNDyzZjqCecR7/kbnPESwsyajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329299; c=relaxed/simple;
	bh=DulhRSL/fgSCpa3fOBOXvk4SYe2iovHQU6f7AjnHXdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Hm6EuTi3OaPQevRsipUJhG8gQI01uJN69tt/EnarcjFNEFfumRdmolcpkM69+TutPaZ3neXW2IHwzBx52GgAPw0fppFR1CjHW1nl+bj5MSQ/OoLYghjJx6fIix8WEqACa9dZISEWj24kHQXvK+MmIJf1sgpplbEjaAUXKAKe/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQISXu3j; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3381df3b950so27050771fa.0;
        Mon, 08 Sep 2025 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757329296; x=1757934096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpBKxliVKaR51w5Vb4f54XuL/sJUOHx/sRIqbnE10I=;
        b=JQISXu3jvl++o+s4hWBgIH01IJ+2fWmVPfHShwyzhx9Y3XOfKvtdmp640btdlvyXwS
         H9RZ2fbzSYpvWx9rMg8xZdFZMRtGMt8eX0/2K4hx/2ZacyJaxlQC4Xig/BHdPFYv4JZ3
         h0gmvniZg7ySvaJok8h8WbWL+1i3x9nr9tON3UOv7u5SApQsiMToOcUZVjEBGRbgAofZ
         Jz1FoduTIW8a4Ztz3U/HWWsil4vvqR+7O+vIp/4+83EucK8Ge9ZT8K97Kr59SWDutJaF
         MQx2uvD+fUse1Po5aopHD6sFU876AXvETEKpGYC4eUEyZH3T+9sUqRdY9RdFRFIm9T22
         QlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329296; x=1757934096;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpBKxliVKaR51w5Vb4f54XuL/sJUOHx/sRIqbnE10I=;
        b=BeVPcU1ZNjHNwhSWbssa51ukdEriJINn2CSx0aNxx6KQ9XD90fkX/FyhozU7ExG3/T
         wAmtW/oAkxomme3NDLmWFcywTJPZUo2s03PgIwLV9hOYOczznSP5rgZjyt51DdHtIyIL
         rzTzYZTx/z8y6jy/hpHY0XCQcnhGbeRJFrbmV5VE5fZ+t4LzEyGbce77WAWwJhw60dbG
         BZrwbhdw6+Me2c0t0LyRqxMB9wSbjt+3PTOFCwMRdXzHzVo57HYqOPDcVmbGZQ/LR8e+
         9BzR6z5Cd2KgsLapIkWdN0f8iueJCntZa2ZCTYHoZxphfggutFZaLxGj+t4zPGm81rRK
         r71g==
X-Forwarded-Encrypted: i=1; AJvYcCXMIWi5uwQ468CUZMBl8rMhRg1ibtiDlEVq4aI0hOKIlJmyNWuRiXmn0RGW0hggf03dt730lt2R0W4UeGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUO8SlY+/UooEbEUfEZGQpHyDOZs8lAkr6lQ7OzicjLjlEbjmx
	CAWOVZklEuzC9bqgzDYk9BYok6wevjX/o9LDdlxv95Y2tNAVdfbOvUriaA8s5A==
X-Gm-Gg: ASbGncuu4hKfKMNl2NhIzr6QCERWTHtiwsHCktrAOA+vsbvX0UCo60NNqtNB1lWeg5k
	EK/bP7rETVKRL9giDUZMXm0XVyA2YYnYhkMaRDHYUfPHV/pIgpO57y826FHgMe8oJEXGVuVEiqy
	WZW1SK6KxR5MJRvOYDDEo6UG+Qixnfr/M6I5ujfDYuXm45yKLP+MrSQeqIK6q4ALderi8QNabo9
	ryHTogMQ/yV54CEY0nQhPTF82WR1e1Rbvtar23k1CzYIZHfW3ZWu9D8exhi2GKxAcT2/zKSI3wr
	kHrbq3UF71k8KSEgnz6b1AFlQVmJVdSRacQa83Y04m2vb/Xd94wGOzPB5Vy8j53P/G/tRAGXRyd
	VjF+JbpLkwMwHtvR1GedK8Faj82Iz6v/7EgHZHTKT/BaQmF5aFB3HB89J
X-Google-Smtp-Source: AGHT+IHy+/IKUpsu35aJuxofLD0cd8QtAbEg46nsvAa3s7NErzBbjvc/uu0pcGjCAefMT8rW2hE43A==
X-Received: by 2002:a2e:bc09:0:b0:336:e32f:7a07 with SMTP id 38308e7fff4ca-33b526a8613mr17594031fa.24.1757329295421;
        Mon, 08 Sep 2025 04:01:35 -0700 (PDT)
Received: from foxbook (bhd197.neoplus.adsl.tpnet.pl. [83.28.93.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c50f79sm33131931fa.1.2025.09.08.04.01.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Sep 2025 04:01:34 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:01:28 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
Message-ID: <20250908130128.7ed81912.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mathias,

I wanted to finish and send v2 of "Simplify TD cancellation and drop
some states" over the weekend, but I encountered an annoying roadblock
and I need your input.

Basically, there is a bug: URB_ZERO_PACKET is queued as two TDs, and
when the first TD halts, the driver simply advances to the second one.

I found that extending the event handler to cover this case requires
multiple changes:

1. obviously, all TDs must be cancelled, not just the current one
2. they may be given back in weird order (waiting for Set Deq), so
   we need to store the status on urb_priv and override td->status
3. xhci_invalidate_cancelled_tds() would need to recognize multiple
   halted TDs on the same URB as valid

This is doable, and I have already implemented most of it in that
series, but there is an alternative solution: simply stop worrying
about halted multi-TD URBs, because this is the only case and it
can be converted to pretend that it's just one TD per URB as usual.

If you are OK with this patch, cancellation logic will be simpler,
because this time there really are no remaining cases of multi-TD
URBs except isochronous. This is clear in xhci_urb_enqueue():

        if (usb_endpoint_xfer_isoc(&urb->ep->desc))
                num_tds = urb->number_of_packets;
        else         
                num_tds = 1;

Regards,
Michal

