Return-Path: <linux-kernel+bounces-849834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2FBBD1092
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA42F1893C15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6488213237;
	Mon, 13 Oct 2025 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgf29vI7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75200213E6D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317326; cv=none; b=NfpgD0voA/EbCGPLlMfiNu55ooqovgYtFi08NHlfm+rl1oa8A8SoUIAva0sy7RJWhOYXrMx+2eWpJLoDsu+g9iDBK2hWbsLn9ULpRXaUG49jvD0XhWUurDJ7XukbGQsKlo1ne2P1Ry3/dZEvKqTRKOyhEpmrP5tzOL6S7eERkKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317326; c=relaxed/simple;
	bh=5QsolDiiIg8i4wa9pi0bcArvGbChTBgEPx+xwIk7v7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I/ndTSWkcITju0N2LKegYVULDAiGcEis3zKai5oIfh815ccC5G2h7oq7RjtXC+EXBogssdsiuuyZwUzZM2cCNXTCKI5fqwQZRdQkw3FamThG3R+F525uckUPcXhbfX3pDC+Ej5McBfHyh82hkxzUZoruC354toWNAxhHvZFKTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgf29vI7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-789b93e9971so286599b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317323; x=1760922123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2VZD0X6ZKBVyHcu44cQwkRlDd6EuJvxZbXDHRQf7Yk=;
        b=lgf29vI7dDN5ihH75+KrCjSgi/mRIsILTZjpQgEysVUllzni6IGPt1a4I/EkTxvLBw
         pkdLb0E93Ebe/GTOUAjXfXpp/zFcWDDPt1u3qiMteKyK5fQZfXRTVPfBMMM2V5eD6b6D
         DXl2Xj7CgHoPZVv1JLC+KLiNyB79J/O/wMbJaGynyEBUwVxT9fXFG+vfirdusdsNEK5n
         91MzZpD/kA+kFEL/nBax17EL8JlJuJ0IVskrz/7t2yw6HAe3YkSznT8/KA/dkWZVDYQB
         2lu4q/oQeNGMF6a8kuIPsDSLmm6FCcj8KKwQNA1EcHwoXvgt/366HB5XEguVEJhVj2B0
         vkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317323; x=1760922123;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2VZD0X6ZKBVyHcu44cQwkRlDd6EuJvxZbXDHRQf7Yk=;
        b=ww4K7bUDGnAadkcXhddESpK+yNS3Pv+H9+/dh9ppFbP3UAa2FYW8gylC4uKP6EPsBa
         2paW2JFo/x8rmDaLjzazt0UiOSPMyAuUMr7I/y12UgLtBC58rdIMg8MEUTMqarm8ibqx
         Uh2ziPUhjdPeoBlTOvjyfCsHhIGm5TmovOIIY36AV/mZ0VsvPMPAVJERf0vihwj5OXZ+
         OZ62qYQExdivc5QBdbCg4caDM0J92a/XmcHjImDq23TzOLJadCHPM3tgjlU6ZuCkdMup
         NViZaUbINr7aigY10ITCVdsJTYcQanAMmblmIRWKimto3Ibw8eDR2/+prplufc3U7tfS
         KLVg==
X-Forwarded-Encrypted: i=1; AJvYcCWGGXzDrYJq7D07yhKuwjlfbz1FqMFBDB9GcdkhvvDx3UJuHWYuN6AuzpN3JGird7/Ex0EnQTpcAKqOAGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4NM72UlWhuDDXkvhq1b9RgbabUHrwzKnknhP46txRF/wwGluH
	XtWnopr8RCEF4dH3m0sJWjTSYm7swR86azdB1E2hbX8jwhqIr/QHFUEOJxPo9LGfh2c=
X-Gm-Gg: ASbGncvLz6VmphNLid3MURkNGGwx4GdqSuQbuT1v6FYOecdv8ytLJuuyvfew4mG5EVX
	pAcftYeH/I7/yJUyNPLrBlo+92a1r3nTn1Vl8T339yCdMZbMMKzHWQ9YpAebVQffNYNko/VihAe
	yYz4fH9M6jbiNwzW2uu87E5WSHfj0jZL+jAjMe2CRWGjKGrwGoVBxCZK/yakcUZJP6hLigIcihe
	gjlbxyexNpcilKv1hSXxDTlKSoSfzGTjmCdSDswTL5a/lQritv1Ef6aUkldGQRBH8k573e00W5E
	Nig/wOu7XX8Gt03heoXvGG/o4mLlnLY0LqYI93Us05H5uSMUoWe8IkRIEUMH3Wu/zy1epSHfcKt
	hcwieLEPKgH+t/GrgJJH8jBqsMN/l3WXD+0CmTNwrkMKuvgznkWFRs1Hrzuoz
X-Google-Smtp-Source: AGHT+IHkhsD8Q/l6W8s4BND2jDztyLoKb3Ag770eBYI8rhYQWaZ8cr9fIADYoln3Ut5t+SFwMBNglg==
X-Received: by 2002:a05:6a20:cf84:b0:244:aefe:71ef with SMTP id adf61e73a8af0-32da8439bfemr12149595637.6.1760317322630;
        Sun, 12 Oct 2025 18:02:02 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:02:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, sunyeal.hong@samsung.com, 
 shin.son@samsung.com, Raghav Sharma <raghav.s@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, chandan.vn@samsung.com, 
 dev.tailor@samsung.com, karthik.sun@samsung.com
In-Reply-To: <20250925130457.3476803-4-raghav.s@samsung.com>
References: <20250925130457.3476803-1-raghav.s@samsung.com>
 <CGME20250925125624epcas5p1b8da5d2cca89128d286f740b9896c609@epcas5p1.samsung.com>
 <20250925130457.3476803-4-raghav.s@samsung.com>
Subject: Re: (subset) [PATCH 3/3] arm64: dts: exynosautov920: add CMU_MFC
 clock DT nodes
Message-Id: <176031731657.32330.2231798506683118457.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 25 Sep 2025 18:34:57 +0530, Raghav Sharma wrote:
> Add required dt node for CMU_MFC block, which provides
> clocks for MFC IP
> 
> 

Applied, thanks!

[3/3] arm64: dts: exynosautov920: add CMU_MFC clock DT nodes
      https://git.kernel.org/krzk/linux/c/e3be50e829aa1aee713bf0c6907acf13d48be310

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


