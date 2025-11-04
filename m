Return-Path: <linux-kernel+bounces-885372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7AC32B81
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A57A188D3AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F333F8A4;
	Tue,  4 Nov 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFO5WWTk"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D433F8A5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282699; cv=none; b=Cd1rEHEeQY2491gp8t/RFbueixkWxVZlKLgUtt1+FxHi1JAvDzTBWpgtVaX37xNoAzd6GiUd/oN5WaB7umy2KwBOxKP5PN2AiSrl+taRutPGaGvp7XETai81e1LtvLVEIk2jv8xyShLSBORBxNXYMfHkrbcwG+SN+y7gi7Cr/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282699; c=relaxed/simple;
	bh=sXJ6oo046UdvVw+WZY0s1bpUrcjoT8rdWb7NkoJ1tDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr69ZZfimIgTOlWEtGcf9jrmsHy4L73+0M30ZIPLR6Znvk1zTbqlzmuyip+kigdRkxJZwRn9Un2yVW7BKU4O4qORXPdTPx7O4lG1T2JQUuI/tK7yPvBBHFcsJKB63g6ozYH/wrSnNJkbsBmJhxBRvK/OUrK6TfqX1qqqi6W6kbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFO5WWTk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2951a817541so65008705ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762282695; x=1762887495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6B+aPmBbpdYFEZ5jj5U7gq6e1DRXMQ9PT8K+t5rVros=;
        b=PFO5WWTkj4Wr49uMspyv2IJ6/mfwA8B0MrW1oowem9/90Lftns+R4fAJ0n/sccbfF/
         iesuUKI2oiUOIMq7D8wJyX87ZP6cGXNg8E048BpBcT3/K6G/zA8/4/EomHdkzbDS89kl
         SD8+PfwLZ/fY9XnKmnjzihts7/1Es4UU48tnRNu9oMKmwRJAiHD0uWkLqgpnX2Az1S/u
         VN69udvM5nLwKm9vYNcmnHG7PYbY2vWbDkH2s/2eiuPjrJ2su3/In29DinL3JAEp99yZ
         qbe6sasOwTY+9kQBaPpUNZ6zMpXnn6TcXLrW8eMwT2M4MFhJf9nRQwMaKD/fiXz8swbp
         yYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762282695; x=1762887495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B+aPmBbpdYFEZ5jj5U7gq6e1DRXMQ9PT8K+t5rVros=;
        b=XouCQU6ZKEEz0UGDhyXUINeJJ+rW2630M4TmDrrlN9tnZ4bYgV+XQ4VAOL76An8iN2
         PxitlqRal56TooBGGnSgDfoMxjLX+yxaO+zB2l3vWMAR4uXh1fp8fVHT7dR91UhE2KS5
         ZzdFkEm3KrUs4cYuJEv3hrOaBZhCWU7XWLfY4mWRsyxnhxVznFRPflkT1ACckFQ43DzB
         32WOiGxc1CaTMeXzKlGqaNPjkq4tDH0Iv9mOPPd0ZWN6aR/uuRYq6fZTDbs+2fb7XQRp
         IYzyY2I0xHYpm23azp0Eyfzno2wgYs6lZgYk+xK6RQfi065OgFsK+3L+p/tuepKpvNJg
         85Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUrM9MkBfDl2B+l757/EoRuG+JZaI272Ac0OGREO7BHY4SwUo4wAzGhBF5d4pkvTFEZxMIb4aptjlzH+/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZzKz0gVcABbds1WBn6pDM8JpQENHhm5/Z0pEwh1d4CEi2304
	3QiMqWEtD+y5U5Seec7DzzeCZKt1GWiXqvek0osFcVP8kAIxh+FCh3zT
X-Gm-Gg: ASbGncvyy3s7ALawf7U/YUodS/DteysCgrL9BKwiaW5tIbtJ/KY06CldXP1TIarhDOO
	Ri7apAQYehDTcs13bjF9SnDyw/bcvL5qmofctooAJ7ZV5xVXT42rmGTQL8O8Gwhp3zpn+m+d0jt
	Y1obTd9gSNOxLux9loELSae16zDBjjHzsfT8/sY4k+TdTsKcaEsBT+vw2d6UqXcjQYn+pTeaM0G
	/qa2xRrw3il1vuWMv4Zyjrz1C2NIDqQaBf+JqatM7g6iRIkwdFPdA2oYM8ZMHEO+4vZ1v5Dy45P
	KZo6EIRlvLmlbeJhbNM7Sr/FKHiCehW7iGKnhE0Wr4RUqeDGx2ofL4uWjiXBOtarbiEuf1IobjA
	dfppgmcWnmWqAX9+Xj3+BZtdaFHq6/CKq4i6nPTcWjHUcr9MTWmEhddsUdoIwAr/JGTBvbQhcLh
	QoYv12kRsxgXgHnuYeBwLoqa0sp0XrhhXo2FjSwLf2zA==
X-Google-Smtp-Source: AGHT+IFHo1RV7muJZAmmalRPgMc0IPBuau1lfoRTnOMDYdIJrPmtkFZaswgqqRuY7j3qYZj5YpoDdg==
X-Received: by 2002:a17:902:d482:b0:295:425a:350e with SMTP id d9443c01a7336-2962ad0c176mr6981645ad.8.1762282694755;
        Tue, 04 Nov 2025 10:58:14 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1f2a:f7de:951a:621a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998d4fsm35273745ad.43.2025.11.04.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:58:14 -0800 (PST)
Date: Tue, 4 Nov 2025 10:58:11 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Anson Huang <Anson.Huang@nxp.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Input: imx_sc_key - Fix memory corruption on unload
Message-ID: <uimkyxzdrcrcm6jmprcsnbl7pw6w3impm5dqam5q4gln3lrcwi@ngqtd5pbuywo>
References: <aQYKR75r2VMFJutT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQYKR75r2VMFJutT@stanley.mountain>

On Sat, Nov 01, 2025 at 04:25:27PM +0300, Dan Carpenter wrote:
> This is supposed to be "priv" but we accidentally pass "&priv" which is
> an address in the stack and so it will lead to memory corruption when
> the imx_sc_key_action() function is called.  Remove the &.
> 
> Fixes: 768062fd1284 ("Input: imx_sc_key - use devm_add_action_or_reset() to handle all cleanups")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied, thank you.

-- 
Dmitry

