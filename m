Return-Path: <linux-kernel+bounces-851354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3EBD63C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D483E12F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D002D47E4;
	Mon, 13 Oct 2025 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvAVBQqs"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DF2D949C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388365; cv=none; b=mnw5OklzIFlizhKsGfkW3cFjdqWvmRx6I6KkNQUcDdeIdR/23GJlCP8TJ4FW2yj5ciQRR5/j9jVFclzRjKdNJtuqNclfEoCHb/QLc/VQ1lCB10D+X59YDjSMcQGG5etU/ufDZjFddZYdbfycxfqgmbWz/+KLrGc7SGqAFQwuoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388365; c=relaxed/simple;
	bh=99QjUoMLoVQrhY3mrpehmIsZka20aMAz1lwH7oyNwYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV8XsKTMcCLIC8tiePtGI7xgwgx8WUtDnUT7dpyof2M980CIqUlb0nlDB+3XmcMBX4qN/zQGpBpMJe44XvDaBFxzhcpnNYd7rTzl9tMdy4tXGhWE+El9c4M1ZsP+eaQVE7+yWtKvJcusHyJaOvAUl3mjC+/4iNqjMs1kFxSixKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvAVBQqs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3713614f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760388362; x=1760993162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99QjUoMLoVQrhY3mrpehmIsZka20aMAz1lwH7oyNwYw=;
        b=wvAVBQqsbnTT+WQ5q1j+wr4/lzjUSLc5g7rQSEGuDNyJfzOLoVyRb2XI16zXEPFpXy
         +7S0L6Du7zvvISBuz7nuDsZMLlw8a9W0vvOpib1w22wjJML1ckNOzwI35p9P4pYG+Tf8
         q2YDy+mzta+G3RpYdmvwGzgVZqCr+yslcCMONFq+V0+nmMFDZZ/eGaKblLBhNO+W9QlS
         6Hvj5XVBX2bPv0fU/wb1gJeO3z7B9KvV+rL8JVurZfmk8AYrSPtm1LOr+k7oFXWy4W6q
         VoVKp5seCOSr/acE4y9cQmhjeqQji/kZk5602k0lEfN4Muc1GAWDdoGAkMfYuIVTwBI9
         OWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388362; x=1760993162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99QjUoMLoVQrhY3mrpehmIsZka20aMAz1lwH7oyNwYw=;
        b=hlz+T+yEoKsy5NkleeiKCLvGsz+n0skflOEtWV47Pfx6agvtH27fzfWzned2Dy4Q30
         zDZtejBQ9y+oSYTlbnn/Ujx0rYxG3HCaJihyDWOSo41xBzimPyuhfxn/u+qqkPRfPysj
         VHfoMPp2pZTUE+loSvvE8LUB3YRaQ7UbXPfTyl9a8pG0SWi08ICV3JkRm7UFACJlC+F3
         +ZSGClmgs3+2DXxP6o/xwsYsFo44WL84T0oJoDrcpgFycEdZpQCDzHP4iDKjBzmDKQPV
         CrccSqSk+DpPUAKbDMS3YHaWoSqab9thw3d7onfdThM5xkBOxP2Khh7hZT59mUufdP+v
         QJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+3BIrQq+jUmJnMqT6KggD/36nbgI5J+X8LcTLFX7RPHVlTPOxx8y6FtRtiR7lAUkA51PQ2b0hA3B2Nts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPEnlb27i2f27i2mIWUOC6EAscBcMHBtksndoW5i/xSmxdT6J
	ZkyZ7Qb8rzSqLH44beiDg7rdo20adkXSaHJX+xd5DciBfCxcpXgf7FjgsE9dqLhYpVe4lr4Fho4
	V1QvBvgFHrR9i6Fg/49LL+7M2+4G+axl5r81Q7LDP
X-Gm-Gg: ASbGncswuIRbnaTkm1IaH+IHpcuoZlDGJyWJ6SRf+7Mk3qSnhTE3DZTLlh23jJQU7Uq
	ZEBL2FApBewWXEu7BmEoDc7bAwEHgOAo56KruVFM8X1mrv3tYh97LJsNKHfOcrso2S1sTVdigSJ
	xyzDE7a6zLxIRp4RfC07/RSBHqoA3Q9wmiO9bRfx5mj6qB9OOtLemTY184ovZz1PVTKdm4MBQwX
	0ZV74iYJVjL9bQnIH3u4X9ohK/E+ALVGN5bGVUxbEto9sJju1MgtjJkuU7mmp1TyEwGRbgeHQ==
X-Google-Smtp-Source: AGHT+IE8TROKuhNVu/BWqODTDcSV9rDf2MBMkLJcEl030I+lvoxpeDpI1cmeAFlCMdh9HW11ihmrMXGez5UzLgpHrN0=
X-Received: by 2002:a05:6000:491a:b0:426:d53b:4ac with SMTP id
 ffacd0b85a97d-426d53b05admr7436865f8f.36.1760388361662; Mon, 13 Oct 2025
 13:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <20251007000007.3724229-5-jthies@google.com>
 <aOZhyhmIv_d_knXK@kuha.fi.intel.com>
In-Reply-To: <aOZhyhmIv_d_knXK@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:45:49 -0700
X-Gm-Features: AS18NWChD4MSZ1x95bfLrGIqzvRKmQSlLAN19rWkyqbygoElJEKAFbCC0PRVrEQ
Message-ID: <CAMFSARctns_u+65pWH8+j65bv74hKcqFBgbZzCEH2PO+PQ5+SA@mail.gmail.com>
Subject: Re: [PATCH 4/6] usb: typec: ucsi: Report power supply change on sink
 path change
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> How about:
>
> if (change & (UCSI_CONSTAT_BC_CHANGE | UCSI_CONSTAT_SINK_PATH_CHANGE))

Thank you for the suggestion, this is neater. I'll apply it to the v2 series.

