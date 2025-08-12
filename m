Return-Path: <linux-kernel+bounces-765494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57AB23919
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F7916A893
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6FF2FE595;
	Tue, 12 Aug 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="A+8neLnf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DB27587C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027452; cv=none; b=KmPqjV9KF4o2nsu1wPSmbSwdmZAwurhCBu4R1xrYwiQuJYUPlotogMalvV2bmruQvUTta7Os7WBCnXTlTLDThmzfhccUh2mMB9q/E9ERiLXvta4hHhN+gjzWtqZcAUNztczvWMp6bM+zknmYfFsSxV6k1ETHT2EMQDHJGyNq4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027452; c=relaxed/simple;
	bh=lpjEYtls75Mz8HuyMAQeOkeLsxER9FsyOhrBS6beBRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0HIrSh/fFe/jmAbx5pHZgvDIrQbN/p/MpAAoNRXRuyTpGT1JCzTxvknRmNX1DuZQPrFtKMnLYDAbZSweok29n5IVGKY8bnjzG+MYe2xrAM7v5nMPDRwufzBBNBhVivckLqo7oCADT4rtnsysIIqBnhKRv4iIwF9L/AODGMwJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=A+8neLnf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so53139305e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755027449; x=1755632249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpjEYtls75Mz8HuyMAQeOkeLsxER9FsyOhrBS6beBRQ=;
        b=A+8neLnfqxc2SW+xxy/vZ9x6VjD2FJKImHtM6OdzZQk+HC7leAs5gSP5JzYRlU46Cc
         8ITcBz90z7g5GP8uA0WwnMyvKLIhavRoXTc4vabAnb57+eckZPUwFev3hw8c4tJ+SGjW
         rI7Pv/KfvcHRefUN4gaHBmMX0vWKYeoExFiLBFiec38GPH9Syj0YLK8DHgTc/TF9eAR1
         oYqRNiKaavm2FOwNJijtcpsezCdjU3OBF2NfUvvQ9TgYfxznrCYN6jNrbPO0hQg5cyM0
         N2tnwGOiIYz5bNWWkqM2WxXfBA3sbCTbI20MDR+agGidSNqwndbASw/s4XpjWn+QMWik
         gQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755027449; x=1755632249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpjEYtls75Mz8HuyMAQeOkeLsxER9FsyOhrBS6beBRQ=;
        b=bDcLoMGadMv63Hl5wvaA2Nl5EYdU5QIpBQKYcrmEVFDSPsXfxzS22YQ0k9rG/h0tHf
         eNOsjsFIRCqU5H8mBtM57wvpauDMkXQJxG1bV8NDLLKw6F40Cl8/EFmmLaTZ9QsVF6fw
         JX5Zyw7QRHY38/I67gQosLwyF4LKgnXOWivYI2RDqIUTE40Jac+emUuplfn1gRJlKPM3
         Mop2b+hvqjJ1v18hXGqvxcIJzGO+yClFSB2GQR1Xp2QlbpLJzoyVFMM2JFohqcam9uVH
         euujsPiJw7Q8n1OkMtJrHm4FJg10jqW8ZYbXCwmlCFJ3AmAkU8W4Wti81LF0qZgFoAg/
         2JNw==
X-Forwarded-Encrypted: i=1; AJvYcCUbwtyIrwMLLJgQiijKYDiQBWbyNhjti4FDn/MrFlNTY/pZifCEPATyeVdnwUYlmItbRwmT77Lf1MjqU0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUZRBdeokY8S1KPvBnbZetaLaWUZEkOkFFdOZPeBYtX+/CIPx
	JmixDz6bxKzTauEzgEFMAH0I8/51UOiZMd9p1a99Mfmk4UxeOHc86nTH/aW/iilKpNw=
X-Gm-Gg: ASbGncs4WYgkBZ4gaaEap680VjSyX/ssxdxcDx3PRCAZlZ7hCmW2+AdXeOp2RHmKnTa
	8nUHUxvpR0MDlleC3T3tf+J28VhWsspH1ye3KoEQMSfnbNim5t4seGojYdGOMTDs5S2cN7bieKV
	ZaCAUEmoFHaMwr04UXIvVX+KXdnoGR3M511tbEovFIqVVWmFB5+fxvBFfi8r0aVfyQL+n9kKMyk
	T4CRJ7QFtarcVse52oc6OrDMUlcDiXcq3uwnuhi8L1PRGzrjpOVjAmqW8mD6pmvPu6BVU4wF2Nn
	M9sxib/BkCn/i3NmOjdYu+hJXj1Pm91o0N5iYwwLzG1W8Y4ncJLObHpUJxQqQd6WMyz2bOnUnku
	xDLJxDer9nRJ5CAblEVA4a4YtaGCZq7zPw0AaLJLg
X-Google-Smtp-Source: AGHT+IEFG4AR8hyeoi9xGW3i9Kv3cfWS8J1y9CmyOAAwiS9HcKFO53BgEJ6PRTHA6JWAs5T67T1MdQ==
X-Received: by 2002:a05:6000:2307:b0:3b8:d893:5234 with SMTP id ffacd0b85a97d-3b917f17216mr147809f8f.47.1755027448584;
        Tue, 12 Aug 2025 12:37:28 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:631a:d481:b3a0:fb92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac51asm46249991f8f.1.2025.08.12.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:37:28 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org,
	support@pinefeat.co.uk
Subject: [PATCH v2 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Tue, 12 Aug 2025 20:37:22 +0100
Message-Id: <20250812193722.10193-1-support@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84262447-0877-4c52-8c80-65f1288e5944@kernel.org>
References: <84262447-0877-4c52-8c80-65f1288e5944@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 09:13:22 +0200, Krzysztof Kozlowski wrote:
> Property says VCC, description says VDD, datasheet says 5V (not 3.3V).
>
> I guess this should be for the 5V case, no?

Thank you following up.

The 5V line is used exclusively to power the lens motor (through the
power switch). This 5V supply can come from the Raspberry Pi GPIO
header, a battery, or other sources. Importantly, this power source
is independent of the board’s MCU and its kernel driver.

Additionally, the board does not include any voltage regulators.
The MCU operates at 3.3V, which is supplied either via the CSI connector
or the serial connector directly from the Raspberry Pi GPIO 3.3V rail.
Therefore, the driver does not manage any regulator, which is why the
“vcc-supply” property was absent in the binding.

Would you like me to remove the “vcc-supply” property as it was
originally?

