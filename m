Return-Path: <linux-kernel+bounces-808770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B41B50493
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1172A1B231F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C635337E;
	Tue,  9 Sep 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcxKhFVp"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C52E2DD4;
	Tue,  9 Sep 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439548; cv=none; b=Qj6mJ9Ity0zsBF3ardAOEFaq3v3qkh+TKA+l5K0t2nFgmVgRKVYsZkZYYOLfqYa8JuVwE88vNnIc8fmF0rjE9xz5JgmhGsMMEWojKvhBLRcUh4FEP7N/EjqiEo+mnsarUhx3MHPnozcSVJkI/RU7yZgSUGwEX2sS5axmRoQhXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439548; c=relaxed/simple;
	bh=D8P+ydIh1g7UUzi4cVL3bh5pORMt8yqpdxoukEo72Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmfFrGFyb6OgIInqFXaCGcv+L28S1XyA7+cYjz+JVJJytpbLdPvFINJvlmbTA3YwyYSQDmCmkKz1w9TJdUTutbwF7iHK5Ibb6S9pHOiTKr0Uu30Rd/sDL9V1SKU8e6zvD+jCBydtsFcfaHSIJ5DQM8EpHkcR5H5d4mM/3ooYWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcxKhFVp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6017004dso6221084e87.0;
        Tue, 09 Sep 2025 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757439545; x=1758044345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8P+ydIh1g7UUzi4cVL3bh5pORMt8yqpdxoukEo72Fc=;
        b=IcxKhFVpBC2VGiRwoCivOO9HhovqxAkcgW6niZCekZcuVnWH/OgQWU4cL5h1wMrLYA
         gNFqZ7VM+kkIiK7J5YLDGIpP50cpWr4fOuQpsQkqapxoorohWniEZE/JYLHGPj5P705L
         Tqjwm7DAOw2LMi/0qUke5L8I9DPclSDSZG0lESPrDcF7yK9FjwIFg0qCJ7xnlN8LuBVp
         I3Dof921aLs5ORPxK4yfu0iQet7hntG8CyXsUD5HvBE65jW9k6PtNrMY7KFCy0XtrhMx
         zaDqMWgnqRltFfqUiAb67Nu649o9rDkVkI51aDkDM4cdG5UnBEJgfstvJ2d5S4N32oOP
         bJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757439545; x=1758044345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8P+ydIh1g7UUzi4cVL3bh5pORMt8yqpdxoukEo72Fc=;
        b=ZVC1LIkhePLhZDwwtv6RYbA9S3D1GVX1x1sp5MDjF8+nQx0zT0avYD3kS1Ldr/S+6H
         KW3L2mM79o/HX1qReul4t+6uDtdzRyxXvvfmlFJVF4Cp6Q7GGtXC8tA/WIduL94Gpnhu
         rKyYoSmN+2n7zMjF2CmhpKji0TOyE1mc9zNhOlyGc5OwT4YybvUUAs3GQ1HdFnlXjAFo
         iNzBEDoHsUU4E1y1un33pWAYv3yaGp1cc+aHPTGtnFoyD8r9B+9bVGsw/bdcgbdZMwX9
         q6OuHWT/lOTyl5naGx6UQgfncZC1HmoMGqfmmjRBLHuveB41Jx2yCFzBim/+Ko5YECI9
         iIyw==
X-Forwarded-Encrypted: i=1; AJvYcCXQmwBlHbGVQwEUyrdzQK4bnNHvSTL/UNTvdHitcYKn7SBdC7WSQzQU/+WGfbCoo2nj78ml6bEUbfgNI1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2bFy/H4vTpqN29W82HFAmOHBsDEF3TlSYcdAMz2PrrJ/cnb9
	bL+PZEtJRCUNi/FXxFlNbRbnlaNW1AV+r0kmig9rzKtuGAA0NpK9xv6pu0uh3A==
X-Gm-Gg: ASbGncuYdhLKMdkQi/kcuccQ2Zwpc2NCAwTZK0f7pwBRkbas+U3htpWRu0zc0Veibb9
	4b+6Y4zJiAKg356+pbAJoMsYK5IWQx4parWGvXojCVkr+azulaDzO1dHkhv66N0qXdE7mOKpv7V
	KvrrCAyY6RGnN99R5WlMVrrP18DEdKYx2LMCvV4hRq2yQFUz3OZv/951NS7G/qnpVAawyeXRJl2
	dYctmC548bGGcrSw/g+8Mjuc/+cuLS6DwNRB8DyyL34l0aHEU8IBKlv/7vMyGQ3khU3+8qHkKVa
	rhaN3//SXTJxofUiw2H2HQW87bpfmK8wukofo+4iTUG8vND4pa8ItcI6herQGE0wTkQZwUrbFOv
	8wqKMhxUAx+sQnC8RD/AOMZ0NOsKAzGgOobT47j+vdM5ccQ==
X-Google-Smtp-Source: AGHT+IGxkJ6SEZ2Sv2UhkNnI2cJcU4uiq2WO+Zps2TWWvKEfWs+5kkxgjkVAnKXEzMNzouKco2urqg==
X-Received: by 2002:a05:6512:1049:b0:560:8d97:8bb5 with SMTP id 2adb3069b0e04-562636d6312mr3872923e87.29.1757439544516;
        Tue, 09 Sep 2025 10:39:04 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56818dfc960sm645864e87.141.2025.09.09.10.39.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Sep 2025 10:39:04 -0700 (PDT)
Date: Tue, 9 Sep 2025 19:38:59 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
Message-ID: <20250909193859.73127f85.michal.pecio@gmail.com>
In-Reply-To: <6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
	<6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 16:04:33 +0300, Mathias Nyman wrote:
> Adding the zero-length TRB to the original TD when we need to send a
> zero-length packet would simplify things, and I would otherwise fully
> support this, but the xHCI spec is pretty clear that it requires a
> dedicated TD for zero-length transactions.

You are right of course, an empty TRB in a TD would simply send no
data, or maybe it's a TRB Error, I'm not sure.

But this is not what this patch is about - the trick is to use an
*unchained* TRB, which is a separate TD from HW's perspective, and
to count it as part of the same TD from the driver's perspective.

Control URBs are like that and they work fine. They can halt on any
TRB (which are all unchained, per spec) and the whole URB goes out.

This bug is (probably?) low impact, but it bothers me because it's
a design flaw: either non-isoc multi-TD URBs are supported, or they
are not. One or another part of the driver needs to adapt.

