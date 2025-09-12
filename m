Return-Path: <linux-kernel+bounces-814278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB28B551D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1E8BA1625
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51495315D59;
	Fri, 12 Sep 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4ohENhj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A5313535
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687761; cv=none; b=ieC6qwSKIZiix7X+cZOEfT2jQDNLp8YsN69rUJbsckft2GEHrqdtkIHB8ZEDEuiffEn4kmnLobwMx2QnwCC6hBFS8jCpnIix1s9b34rG06cNxiiO9GC8hdRVBkhO3ysJa2yhRpaPyaZglM0KofNyrCuFrnSMcwIvt8Vre31yKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687761; c=relaxed/simple;
	bh=w0HNyCJgCIKMXof21vkl4pN3VquJKbWAGsmHF0hWEh4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kPGyk7ZbBB6u7J5tublokHXkj+aTYvG1rdFuNI5dO+AvjyzAFV4lmzLUrE+iW7HTUdkD+Q3yWbvU8Oi9TaOgmMYKevVSOLsAdcnHrWJDV4vDKeweTKqKNMlH3T8F3Epn8iO6q3hVepy70yaMSTMsOQ7WuFpi/8SZJP3QAp2xAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4ohENhj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de1084868so10301355e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757687758; x=1758292558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rux3uIEwt0djKEKrlDMK9wf/Q+VyRMin5568hbjdQuQ=;
        b=P4ohENhj3OBByqOOeEbxfgzwL3xwxDLKHz6Zdhpph2yJo1NZ+pXODd6pPD/pyHhUYY
         JFqwan1TIT6J4jpigXj/Kq24/REFy0L+ndyPRJ4WckOH3t2WHHiunNBdD02gBySAtp4i
         tap7eoewKLh91qorDe/SWh8D6CKWxhLNaJTiYrdVL6d9zm679o2puGUlgOnAOgGtsBat
         +kGgRk7CEin6ZKhkho8Rl9PEmmmZizfVbprJ68pvfQGL0k+ZfcVTUBBy01svq5BIV/Ch
         7I64G4DYVcs6RiM3QGOQPMqAXW45C0Vwu9PYzNrxr+jrWbBwyREfYHWjPHqmHuy+46K/
         yMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687758; x=1758292558;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rux3uIEwt0djKEKrlDMK9wf/Q+VyRMin5568hbjdQuQ=;
        b=Sn4hg2erGIz6lpiYd+/2keeOxjkabKIHN2wZtBK1Hcaz5mkgZ7nyYSeeLbK85J+GOV
         sAy19aQQlDrkzx8QAvdPMA57Wx/rBxsQ7eB/zchQvs53+aU884ZCSFsOja+xGIAhtJb3
         jVXpJlvCGO06oA9h3mFHMKOFuYp7ggb59uI0wIS+29Q+3rqamGmZDamaQUTDPdjSNcGm
         XbtBv9RxzS81o3l0cjqmF7Uid0N50NS7ELJB0lpk9I55PglQwVHXyNSKuxKD2gpTz2sY
         X3EihEI3IAHSXsUNiicAJVbpJ/kq7vUuLRQj9Ef6zI+92Bg15YwCmUNQ7co9AuUt9tU+
         X/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUIfcVYFa/9JCgSngUVTFgbyt7OJrz99U3qzp3yWoxqqe4gSCfGwolTmdjElEz0ZxaXojGp7K+iCAz6rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcgEsViZ0FyPzpCRrYROcrez/NnRlgVGNrALlwuFQDGkqXmpO
	Mha5kVSScm610g8Rt1hriq21lJ7pa0S8DKk1AfntnFqrw6N9tbYMEqh/F+9dQRQ4f4nYxaT45+t
	3+TM4
X-Gm-Gg: ASbGncuEpLQtU75kG2j65Vdolb7w90rjtXU57pqJcASfo/ZlScQHY0SVt8Urb7rlBDs
	8xUMb9TdLmTkZqH1FrjRxOAWv3KYFBVj7JGX7ZeRgQSQ0Wquy8FxUUrVfJzqaTmLcgm77+S3B7X
	yEz+rOPBkDIP8OtSiPGrAdnzfyMAYA2xUJm1sHMQ234OPpnE3BENv6VjxGUFwj5y3cdXEaNv+BQ
	DRYIuIxrogxtcwFYDtYPHehk3gwTo2iOKJxkgx1/A7TOxsbUjmXZxIZmm9PTI+GkN+NSLKVgOzw
	54s/mmb1TzrBAe81Z/Q38yx2Jm8vhk9ZKfy35WWK5z2aFPOSRcfwj0exB0CCUhs4ssyibexUk2p
	2upP+p7Q/5SicF/7WYuyCaPUW21XpgHB9BA==
X-Google-Smtp-Source: AGHT+IH67tRYiTRZR0HlitAXkPqySgTj0c7ALy1itAhNYgQLFYvaB09Ls5bZvLW8qeoaRRjgwtFi6g==
X-Received: by 2002:a05:6000:2408:b0:3b8:d360:336f with SMTP id ffacd0b85a97d-3e7658c1c6emr3279136f8f.28.1757687757628;
        Fri, 12 Sep 2025 07:35:57 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607ccf9esm6659591f8f.40.2025.09.12.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:35:56 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: frank.li@nxp.com, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
References: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
Subject: Re: [PATCH v2 0/2] clk: imx95-blk-ctl: Fix runtime PM issues
Message-Id: <175768775587.453341.7630569911585966967.b4-ty@linaro.org>
Date: Fri, 12 Sep 2025 17:35:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8


On Mon, 04 Aug 2025 16:14:48 +0300, Laurentiu Palcu wrote:
> These 2 patches belonged to a larger patch-set I sent a couple of weeks
> ago([1]) but I decided to break that set into smaller sets, where
> possible, as they will be easier to respin, to address any issues, and
> will probably be merged faster than the other one.
> 
> Also, I addressed all the reviewers' comments received previously for
> these patches.
> 
> [...]

Applied, thanks!

[1/2] clk: imx95-blk-ctl: Save platform data in imx95_blk_ctl structure
      commit: aa1735d72bc085c4d107fb2017c597f83bb9490c
[2/2] clk: imx95-blk-ctl: Save/restore registers when RPM routines are called
      commit: 14be8b7b6cbc0a072c749e46e28d66e0ea6d0857

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


