Return-Path: <linux-kernel+bounces-882563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFEC2AC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7898F3ADBE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F982EB845;
	Mon,  3 Nov 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSa7sb5C"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35792900A8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162405; cv=none; b=XEdCPIcZg6xUsfGHpa4lLOimqvamwPHj1CisRyT3/Px0TqYVrOyguz1Ju9O8z2CKBaENIW/AYDTiLwiGpMYmJKqL2fgB4w5G+5n8m3Sl4X+IDfxfLQ/jcMUT6souaA9SjqCW5KLMkRsvdooFAy+/8V6JsQ+Dx8CYRfWR9SM3RQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162405; c=relaxed/simple;
	bh=c1A0QWUdxkJKpRTlrVIzDoZpeSzx2x/Os/6OQGH0TtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnCnq6UPnemK6a981sUsp+q5F3OAWsR5ZJZIxrdC9qmiYE/BL+Qeduqth0Xg/417rQa+mJNZLrcR1rOdVNYrYP9ru3C4UrVM5dHtWQoDrwP6/Ycnq/z3ZUCThkh/jlAdtGDRV0HwaW8aibt8IEXGPO9iKlz20n5Dti6BX4f1p/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSa7sb5C; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2951a817541so41421665ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762162404; x=1762767204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi7edW2fKbyqZ3kHK/AlGvcaMEfMr3O/Cmh61+xdw30=;
        b=PSa7sb5CBWAn8It+shTtlOR4Q8S1+W3sumQI1DqXLvo1uqtOJH9TY1iaBEtjOMreXc
         LaJ4TIxhzrx18P5cMBRV9g9lw6kHUaxO3TuX3FF28js8E5Cemkvt9LppHDvH1gxRbPtg
         2AZ81LuWZMvic7uSj673VPxFWjYUzFK+Zi2QIfziMrGvoitxBWIKz4OaqjgVht7VmsBy
         5n68vRLa73g3lFqNDwE9egiRtAF9qK01T5o8gS0vdz2k+kY/gFFFgcxe6rn3ecLME0iK
         Wn6C0y4pZeBvZkdxjU/cD8W6puvMfnTgubfXH9vtwOJuIq01ZD3wTE0AA200DXM693tK
         ORyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162404; x=1762767204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi7edW2fKbyqZ3kHK/AlGvcaMEfMr3O/Cmh61+xdw30=;
        b=OTz0dqKXUvh0bynUl8Gr61VcV5V/v+Wh5wku8padxe4ru/SbH+zC7jZe37tG95zVw0
         5vkPN0KkmR50TuTWvJvQHz/hc/YYHoN+00ojZd6HSaI6LMQmkGPphHSgx/zxW0sNq5SS
         OMLbzWr6oci3eW4KuNDBfnU8hYaJWX8RHMWQ/w+OaCg5wGaOWsOfFGlaKYYxv9fDEC0C
         ojjIXDRKZ/EF1bPcwx0zVT988Xuf3w0Y0pkChMKeO8okpCLskwNdtFwWuV0Z7QWjmkIq
         snUvkd6mnY+5Tq6HmnQdhcRGuyksZXxw5Mb90ggBFiA2pCBoprabIE2RjkR0IqUdPMF3
         KVsw==
X-Forwarded-Encrypted: i=1; AJvYcCW3qHk24EtDz1FOHzitvX4vQ1Z82X1arZs/eT23kPemA21ly3mzrAoEK9MNHTwtBhIQAvYY0QQDx3potT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ELqMGXirYYXZCCQBdY0/2M4YSGZKVO41yrYg+nIhyqgTPrho
	WUqkv950ga5a3RCULuKJj29rB18YrTT4+9wNLQVaLlvUYgjW+ZnDy0nv
X-Gm-Gg: ASbGncvSzN+hL4zD1HhzQkeCb6gwDrTKkIfS4flm/W2zzcOLd/uuuM46uj5DCEEdefg
	jwAaKRTQwCfftKkN8i1I3x1pSXqWXPghwXxAdlgH0UBTAzbFIfk/47zM4OBFjuAT7AL+kSH5MxT
	RTa9nF+aHKKQaV5SiveJxaV6w8KweIxPpOXpf2oAGjaRLCFQSnGxhNT0HBcDH4oPkF/C6S1206I
	43b7vc1Bguf99nh1YVRoP3xo70MnZEo2QhwNZcPs2S9HIyEzZRhWmsh0LpZEzIx+4LKCL/5E+S2
	X8QvlIT0jPqRLCCZDc+Q443j+9elTnal8+cv0sKjX9pUlu7bcpVJKL2QjS3zHYjnb2HjSWl1o/s
	JYZG1F0GDIW3B9gePvDPxXfUH0pZVez7IqS/CTIPa/H7yXPV+IE+H2q3qE3+YBiJbxAO0eA==
X-Google-Smtp-Source: AGHT+IEhVI8HLKKsPHJmLdcgQIX3NyE6Qj62NyZlp0rKKc1HR0bkXg6Og36M1Mf5WeEiO70N6uA3uA==
X-Received: by 2002:a17:903:11c3:b0:290:c5e5:4d90 with SMTP id d9443c01a7336-2951a524561mr137993865ad.42.1762162403672;
        Mon, 03 Nov 2025 01:33:23 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ea51sm112351435ad.57.2025.11.03.01.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:33:23 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
X-Google-Original-From: Peter Shen <peter.shen@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v3 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Mon,  3 Nov 2025 17:33:18 +0800
Message-Id: <20251103093320.1392256-1-peter.shen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds Device Tree support for the Facebook Anacapa BMC 
platform, which uses the Aspeed AST2600 SoC.

Patch 1/2: Adds the compatible string to the Device Tree bindings.
Patch 2/2: Adds the initial Device Tree source file.

The Anacapa BMC is based on the Aspeed AST2600 and includes the standard 
peripherals required for BMC operation.

---

Changes in v3:
- Rebased onto the latest upstream kernel tree (Linux 6.18-rc4).
- **Fixed all indentations from spaces to tabs to comply with the kernel coding style.**
- **Updated the Device Tree Source (DTS) content based on review feedback.**
- Resent as pure plain text using git send-email with --thread option to fix broken threading and corporate HTML issues from the previous submission.

Thanks,
Peter Shen

