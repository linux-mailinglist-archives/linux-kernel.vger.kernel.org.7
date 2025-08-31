Return-Path: <linux-kernel+bounces-793387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155D6B3D2C4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2C618936FC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1838025A323;
	Sun, 31 Aug 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOJd5viq"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273E1891A9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756642489; cv=none; b=j+yICpPMaAKiNzmok8bzyy+dL+TibAdLjNuIgAxbJbDLZTuWtD4aiFY5ifxBNUFjrQVNK+n8Y5eMWhhn83JJ8KkDgIjx6B1KrhD+etWRH1b99TYb/Qihj5Gd71bh4OYmn6eM6q589JInDbJlOK2FW4iPfPJFOwInvV9mcqweNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756642489; c=relaxed/simple;
	bh=aPuXpq1/3jiBPymNfKQaTwEd8BMMEOqllpEtuaa6v0k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PjwscCqhjX/U6wf43yQ9JxNh1VXLbJPz+1jK3vNV/cd/GU6o2OCyeY4GFYruxJ8hXYxENAUJ7s0Dy/xI2RzzpysJbZSdWAmenK0q/87juWg9oc25A6cMe8DoSlnU7VWrNDYGPc5WI/y31v7XAUe6LkGsP0uN0+IoQJ5pqVlYFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XOJd5viq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61d1f60aac7so334783a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756642486; x=1757247286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTxRKPjZEMrk5xpNJpoGqFecmAtlBpCsUg4LzjTof6w=;
        b=XOJd5viqS78uHuArUCiY6PYBH8RyLsbWPn6CpVaRJagKkHdwbxFTtguJPOUQefwIh3
         0Y17YX76aB0+jfqaUJhV9Wrp0BC/pvQAnqBiZslbrPmc8vuKSH8a3yX09idBY/znXL4q
         AfFzGaU9IgP9ndLhdhxEdRzpOnLOKISzXNkMcOc65IP4OVEg3yV/v41/WTfo0W7d+y65
         d4SPrgaqfsA/QhZle5YixkLeoucaGOjeOiH/HdIBq5KxUWXIc67TCyCiW7iRWMYsnRXi
         nQtA5ARxy6aPVPE2BRPriAuHGk/x/tUwG7WfFYOzpZWFsyD7ShDAxFBJymap/nohpsLo
         ZLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756642486; x=1757247286;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTxRKPjZEMrk5xpNJpoGqFecmAtlBpCsUg4LzjTof6w=;
        b=Te6948M0qdS+ybwswmbXf9IAftILAeV9cy4J8o/TKSKe2Nwp6yj4SUyhacJCx9oqD5
         YtPY0ePNVgqOLvMgrkD2ZFABSr4d2f6WOf+yaYHgtBcMCH2GwV8lAjFIAIXcHsh5kPLk
         VqN6+PBEtRd/i2eBFAvZlyVnP1vvgmHllon9x2HJvNXm6r6cvOKd9U8j5wKG15irRTag
         vSNeTSGiiCbfKbjEAI9x+Vda/d3rcAuKTNDllq1OZ3NvH8l87L3yBsdXgO6ouCGfZhKh
         gDgPEVihjAqQXleG8/pf/gWWh6SAKLrzuAC4dn1X80YdR5qkEsqrl0YqfNK+CbhXvR9Q
         EsBg==
X-Gm-Message-State: AOJu0YxKsTdr250Nkrucj28bkK+hDH2e4VPssP0tcnuDAMOCe0Scg2+v
	4dlpJTVW8WV8+7da3QW3hcfW8BZM2Qs/GDQEJGKt85QBchYitNV3kbMQDR49NPvsy2M=
X-Gm-Gg: ASbGnctB37Cg2OwBHApQ6zkboZ1SX/sRIhlN65t2Jnd6y2bU5+UjqHiSEQfBOLRn6/a
	Ta7mgQ6DfJw3vW1wd6nlrOZiFy9ptKtvpZ4y3W+Zk039GGJGB3m7M7qSz7PjrHwmXwJ3yr1Uvdj
	HQLt9kQxMOYdJlDN47w1/UfOx2czT9Lf484jnW4mQRwdwP9YVcqm0UhEYmNDBnx8Rm8JpGfqWNU
	HbnK3zU1lxKOfIl+BoeVLMCZDSm3yJqIGy7KsGZROrzt0clHqXW5v99CaLOOyD5lh9V8Eelp65m
	UetCJaXALpupYrMOdoWE7aWNfD1zYy1Li6ftHaijf0xR/yabsucm78Jp0cQra/HvMrdVHClSuCP
	pcvMZr9HnLcnY4tMW6W8EMdF9A1gBhoXFTv+9Crkh+et8Z9hMVw==
X-Google-Smtp-Source: AGHT+IFssW74tvTvjz+3fYjfCLUuZKth/+qKSpghRspCt2nEmIjSZt91Zx6O7q+4cCcgww1rczw3Lw==
X-Received: by 2002:a05:6402:524a:b0:61c:5275:11e0 with SMTP id 4fb4d7f45d1cf-61d0d38e666mr3494780a12.3.1756642486047;
        Sun, 31 Aug 2025 05:14:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5319afsm5194361a12.48.2025.08.31.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 05:14:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <458641ad2d7a7adf30a03e70038304f0e6a81ff4.1755770484.git.christophe.jaillet@wanadoo.fr>
References: <458641ad2d7a7adf30a03e70038304f0e6a81ff4.1755770484.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] w1: matrox: Remove some deadcode in matrox_w1_remove()
Message-Id: <175664248386.48246.8354721667053625504.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 14:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 21 Aug 2025 12:02:21 +0200, Christophe JAILLET wrote:
> The .remove function can only be called if the .probe() succeeds. So there
> is no need to keep track of a successful probe in 'found'.
> 
> Simplify code accordingly.
> 
> 

Applied, thanks!

[1/1] w1: matrox: Remove some deadcode in matrox_w1_remove()
      https://git.kernel.org/krzk/linux-w1/c/25fb0ea986dc10e05f3f4b43cabde4d1853a1fd7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


