Return-Path: <linux-kernel+bounces-887552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E631C38814
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 036BA343D67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A381CAA6C;
	Thu,  6 Nov 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zlTTeiu1"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B541AF0BB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389615; cv=none; b=MDZTJCScxTo0teQ6FNhGzQ1CO+saiTKSxxl6u/u9jvXlc+nTY0tmUw5Nke/Dyw9LssJ+l7kRGHdENMBWK+vF7mT/VmSVqsOicsj/r7goMxc1q0t6olMSz/k2ZTqlGS7p2LXib3WGZ/wBwqjfD0dgRv6atv1YMTJKKBeFCmXiAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389615; c=relaxed/simple;
	bh=8qq2ZhbRV2og48zRUPnewAaBEr0HlLuurubKZsklLAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y2crDIH/gsDyeIxICN5RLWf5Gdg8lwE82Ei4mhQlnnes4XGXk38f+mf8D+NUUwjlBS1knMmciCC2bjsW72wUX/M2DIfCWFFb6H/cGY0J6kA2ZRrNZfU1V9LnmjNADTGvw1xGjdLJEMUyvqoCVJK1aKHFjJGTCrq31JKRijJ3MXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zlTTeiu1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2951a817541so5373685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762389612; x=1762994412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkU2FfTGJiTCARoq1SWVEP1uooasHwQC6BBNqtcJeJc=;
        b=zlTTeiu1LQoSWLFwszQsSVn4KTF9VO2hCgrTCQ2kIhO+GZEhqQC1RkivUgA4cYxWYo
         gCKOknAqLf7cE23kCSjzYG2d0pBGBDve3cOEd7aYIuBRKRRi+BIe60Cpfq2i5sUtnhZ9
         QNlrG528s3XnRa6uXZFjJT7A8dRqs2hsMkIn6U/XXT4+s5ueprfwXSl656Tau/djgC+x
         +FO+JZKDFCZJAjsD6HItEzF8Ge5bYxlStbhrIJeF6TDD/liJKCxcfxZfThNOEHSn/OL3
         C00V1iSmSAiWZTW4bUHwVGEByebxOccdrN6QUbgyZdqN46bLT3yPyubIonWJ1x7hbNbd
         +w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389612; x=1762994412;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkU2FfTGJiTCARoq1SWVEP1uooasHwQC6BBNqtcJeJc=;
        b=F9+1W7xQQfwmri852YH0mnDn45Yz2l9t942kqrOdTJ22hRBcnWaUlTNhRa9Ja+96nH
         HrvhxmSdY++yVgX3bPTE8NjfEZ9xjs7VjiQ4OdOK0i8EZ86AV7IGfRTQiARDl5vQkZZZ
         /pojxk+njJZiIiqb8o+FC4n3IAJlBoPKSA+EMPkqDY5g4lmvC/fpRpBhq78JFIVUMmm9
         hOkMdnhZ888ItKEWKKpXis71ir51v+1l6c5lsT6aVFAsk8o8p7/VE4Uzf65FkQwRKKW7
         j8S6U5xIc+ANH6HVInB7zNxWS2QZQGbmAziR+w1Xk8fpUA4XBXcSh51YbRKWd7f15P7u
         u8qA==
X-Forwarded-Encrypted: i=1; AJvYcCUmPXszQk539dZCqx+SeKL/pSnJFphA+V1CZtYMrt26bvawalfBuo191x7xnYw5yLkU5sMHFpWyYMIxU/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqYv/mEEiUVx35eJM72uQmlH9iFHqB9hfQsqPsirv4cwlYbhf
	cDf/zXAhcjMCA3kf2guOGud2/7S2G3BJOW5YaYJ6IFXKOhON+UJjlsVj0hUhKQ0+UJB5xg3z9Jl
	I/BId
X-Gm-Gg: ASbGncs2l7HShqczAFYX9ZJpvzAUPinDTJhex3vrBBgVGVCJjgoXfIqnkEPqQuMhveN
	k4rHz7D9MgNSNwKZZyr8KbXnpW29oPafqzqxH2SnUfY8jt71EaIg1q09AlN2uciApNKXQntiMcU
	1VmzHYfB8DY7FumyEBuO7PdbnMVaqcL1D4X4CWfe5Logh0hwWWjXcx5k2SJ1ooIu5QdJougo1N/
	/Q7p2zU1v/7fQlpnjceD1Fvi9AYhTRPGtyb+12QsEl1Dm/2oRMLd2F53Z0aGqJICEloaFC4uR+J
	5cpP+Nb4hZPhR2EpJqJQ4A1CWSl78rYA5mm68gUvrqPnkRX6w9EM6Ul2vje5EwGpDeAr0pT3R1s
	XGUQKi9hN8ckXzDrANFd0L7dgisrycgvObgAGh88Zbajss7qRalMOQ8173Keazo/vyjTqer3aIg
	==
X-Google-Smtp-Source: AGHT+IElJ2Zmd/6qjx4CDLzUHtLcy82LmsapEHCX/tbNElSc+kGmtRslt0CXVghdlIDwLr/630JIWg==
X-Received: by 2002:a17:902:ce90:b0:296:4e0c:8031 with SMTP id d9443c01a7336-2964e0c8139mr23358505ad.17.1762389612288;
        Wed, 05 Nov 2025 16:40:12 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c5ccsm7482495ad.57.2025.11.05.16.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:40:11 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Schiffer <matthias.schiffer@tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251105083422.1010825-1-alexander.stein@ew.tq-group.com>
References: <20251105083422.1010825-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] ARM: dts: omap: am335x-tqma335x/mba335x: Fix MicIn
 routing
Message-Id: <176238961131.3045323.8626140069542181620.b4-ty@baylibre.com>
Date: Wed, 05 Nov 2025 16:40:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Wed, 05 Nov 2025 09:34:20 +0100, Alexander Stein wrote:
> 'Mic Jack' is connected to IN3_L and 'Mic Bias' is connected to 'Mic Jack'
> Adjust routing accordingly.
> 
> 

Applied, thanks!

[1/1] ARM: dts: omap: am335x-tqma335x/mba335x: Fix MicIn routing
      commit: c1d5c2026969efa372b759aefb2f3e63eff29aa3

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


