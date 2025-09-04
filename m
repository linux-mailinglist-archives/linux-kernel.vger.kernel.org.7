Return-Path: <linux-kernel+bounces-800873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37741B43D31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47943BE41C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB0304971;
	Thu,  4 Sep 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QucAwrZG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19262FF66F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992514; cv=none; b=kgcGPoAvJryT84LtuvwOltLJgXTWEnqGaujRCPmWOum0EurE50IF5CGDKhxgmMr2215ooOR3y1SZJV9HBUkO+SQfjS3twUHcw60lKAY667ZQMbvrh3E798bib4wwvfvKZpRSmLB9uh7XjxMP3wJ/OOfcrhsnRnuszGLWjP/OH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992514; c=relaxed/simple;
	bh=Ibcbjsz8p4nuEblKkqxuD7gS4VBpsAMM6/vY0nNETZM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ALi4D42lvvRp0EqaomND0JN3q10liA6p9NLCJb7QYy5SPc+SvrN9NClJTnriyH4NlHSHv5CRT4z9RB4LXC3ova6aUmKUNG7B5KIpvdzooCb8XjfnubsZcPtHAnaahV+56cpC5EuFPCzYE3uLEd5XYLRX0GKXGVsUVgnRtOVT/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QucAwrZG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb5492350so7089675e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756992511; x=1757597311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPemxXw+0FJhICaHUSL6epgUI+v6RGxIc62gtZdQfSo=;
        b=QucAwrZGOfrSwyStXrbGY+F6outV6ADpTp4kG0Y6fDOSlRG4yy3B9H7yyGklRFWokj
         3kNOD7/o20rd4Y22T/1mNeAAIM089JNqUtVAfMcGu/NFaiZuKcP3rYSLhK/45Wa77d6m
         GY0mXjjxrsnrl3BGaepv2/HZhvahFnOfFJIODKd7HddWxpulpWFywB64WP83WIWLS0Xo
         Uz4IWxsUkDg/NnFLs4dz9xYpOar9cPOSiSFW1ISrn+p/AyhS0dNwm/FgUEICnejNWE2/
         VnvXX8MfFb3x3H7bKnXwOM2puQy78losjUXIRztqHRgk+6eyVPXX5elW+TR7i4pDYnA+
         CJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992511; x=1757597311;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPemxXw+0FJhICaHUSL6epgUI+v6RGxIc62gtZdQfSo=;
        b=phQMk3sFQyL1/wFLyL7vFmKVISTW8yZKcjVhiZcE9XM0Cg9pT7mPalwqGXMZ78R8XP
         RNyDppl+OnJ+QZnL38Q6nhLml2KtS+an+2FHMaCwWaAZ9KuP02/Dump7uOv7vY1whaK9
         bN5qWjCwkEdWUO0sdBuIdCQJaJ9LqyWaDixEVnHirDSV/muyAPk9qh0pfCC5wLnG4Ciw
         cMcGwv4q7nih10r93hRoN/9MUCTrDSj322u9OzIffxx5ELgPJLWN0bbAKpLL8pihBeY3
         pUCJNvSkBcYYArt6+kE8ROCMU7FP9//iAO+AD6PusEtORGQqN2mA9SedlfGLCJHgz9io
         sHdg==
X-Forwarded-Encrypted: i=1; AJvYcCV4qEHlfP5kfk9J6saYLns47/tk1U+TwpxuSbB8hxhP/1TiUk4vHf/n1vQHuFo0aZjmNcVWP1rZvywbEaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBhX1QMYNZ7htZZ2OLQEQmhaAplq7wPAAKtwwcYBEgTMWnT8nJ
	+9HRuzmVtL6PdgAiQ4TVqB3KD8tlvPBtdVH8irzVM8ETfhXPsZcs3n/lXFVc6K+e3VU=
X-Gm-Gg: ASbGncuC7l7FHDmjI8q01HGZfC+NP7jCqcccA/dhhgcbntbBp82WyBAfo8XkpqukfQR
	1hKWK/+GDS48VckHNNg6Ni+TB6Wk1mjtQ4OTxE95ilHDM4uAgwjJ8/j9TRmB7GGs3Ns+irICXsx
	HSMYDJ8Bfh021Rb8pGjQ03hqaY+wUWnzETT5VtQvJDpPyDijPLgz0DUQRC9BU0WkzFuKWHnczXE
	4o+97JW189YOIVH5MXAdVFm1W9tF4KIX/leNxV7BDFA75E7mXHSSie1eKnIvf65ADr4SQc5rUAc
	x3xR/utZOszxcvaxeEnlB55wmbS3OgiBL9XnHjkfmehikgOHsgMH2AZPSqBAgrndo2IJm8Nh5r1
	KsXGW9ezB5nuKlfGx6ZNrXwLIsBZmt2YrO/H8DONRgdQ=
X-Google-Smtp-Source: AGHT+IFChDxfidjmo6oLli8hpEv8BHitZXQWhFKQ0sFyaxZOzOcsJqvu3t6i4m2n6GGf1/m4WMbRVQ==
X-Received: by 2002:a05:600c:35d5:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45d030f7fc7mr32582245e9.19.1756992511081;
        Thu, 04 Sep 2025 06:28:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm286165305e9.12.2025.09.04.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:28:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20250505143700.4029484-1-christianshewitt@gmail.com>
References: <20250505143700.4029484-1-christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: sm1-bananapi: lower SD card speed
 for stability
Message-Id: <175699251033.3374853.7119442456595565513.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:28:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Mon, 05 May 2025 14:37:00 +0000, Christian Hewitt wrote:
> Users report being able to boot (u-boot) from SD card but kernel
> init then fails to mount partitions on the card containing boot
> media resulting in first-boot failure. System logs show only the
> probe of the mmc devices: the SD card is seen, but no partitions
> are found so init fails to mount them and boot stalls.
> 
> Reducing the speed of the SD card from 50MHz to 35MHz results in
> complete probing of the card and successful boot.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/arm64-dt)

[1/1] arm64: dts: amlogic: sm1-bananapi: lower SD card speed for stability
      https://git.kernel.org/amlogic/c/916fa558cb27182933fdfe82d6d84b437e69349c

These changes has been applied on the intermediate git tree [1].

The v6.18/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


