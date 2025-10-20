Return-Path: <linux-kernel+bounces-860072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670CBEF3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8232C18955A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36152BEFFA;
	Mon, 20 Oct 2025 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JAwoh/o3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22C2BEFEA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934091; cv=none; b=HlxNEaNBvgCEvObiQ9M2068oH6a7rd5OEkRk9+dtHt9XVY7ni2grXgLDw1N+CY8P97VC3lTOVid8qJjwXW1tDKtcoxzwC7K7L6ubtkNkW25t3T7lMpMFsRnkP6RswEucVPMsyCnzYKZF3bq1Sk9VIMBY2VnKr144tkivwb1AFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934091; c=relaxed/simple;
	bh=+YpuvhJCI/yShT1rtWNvOFpxGI7l/ehsFRhKIaNPItU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8kxk80wxUQwmeNYZFplUfkAFRcTtaJPyrY7y1Cqgz307pcf202yyqXEh1bXQsDNZV0a149kLv79psN9aXRjQmAfMFiWXO/rSqO1OCWFbN2OCWOuefpu//scQ8SEnpWDKl0NO6M/tWBslnrXflIAwaYBIVzaVoPUa+9/Gjoky4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JAwoh/o3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eec33b737so59773485ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934087; x=1761538887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=JAwoh/o3l/iy2sFi1ugjUdmHcjBCKevt+8mUOi1sqitp2FwVzGYui3vaZBOuiytuPT
         e1QgVvpp8M5J2ent8fcwzPtqA7OxuFbUDUYhKVO4Kbhp96nSM5O5t+VXW7j/qC2NcDx2
         6xEbZ5nnhwBGTMxHfwBZjfhnuuljD+Z+WTzEz/o9N71R3A5ar1111AqE3jcJCEJR6AlT
         9QI0q9WlWcKyNqJSz5mApRiEwnVH2gndZhW/zopueiEBRED1jTgJchUZY93SftSQ94C/
         DDQVY/VCrnTGtWXCarpbGgVly96YeFbemv55XWqGgSmoTT4c0Cz0A2LCvcZp7DK+9Sc9
         KbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934087; x=1761538887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=MzZDWzHsFgNorj2cEGEv7aGM76Z5pdefYcOjPm/P168L7p745ZzMfcrFkm2ILR/Iyn
         ohezFOsyNgtxQrRhlNF0Qxl/iVSRst0BpKMg6CrJYFstwPrTliJ87Cu3yEYlX9W/Ooi3
         rkBjTPFioVaYwslv8ZvW0kBJvo4iRa0kd3CFRXCnfche1fgofqy2f9gpNKvYW2Iy5fv7
         OxoNtqnkoiqnaE7tFyNCd6waXKpZr9cPayKvY/pVvACjNMJjIl+DnULgsD05NVyljYbr
         hwkCL5QtHGYnNwBdVYfj+V2oBosed+pqd2kOTMGCAXA8H0Zu0GZDUPSQj4G7/Lfj9EEz
         EYUA==
X-Forwarded-Encrypted: i=1; AJvYcCVNw0a75veTXJEKWE6zNQBu/U6o8uZP0b0/+IiQaaaGlZnEXmxLE6TbQ0JeQQR/VMgCI4Gnd6wb/uvybP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT0j7jds5pNtAR01F1P/A0+BS9pBb7hchYTM2EC73y8HSpDUn6
	I9ANRq5aWPcIFfWAU/vhn+uzcn8b06pPrcWFR9t/qcgyIKNyMXQhtgbQZIrZKf4g60M=
X-Gm-Gg: ASbGncuuaP4VlC7txzeqVvRUwQOeXTtwMsSZOFdlwNrLPMBcKC38hTOUSCM2/lnHYq+
	5i9s9+4orMaSxBRCjVQaK4SdZ0ePwd/SrOgZ4njJbUlIhxEbfo6WulUlD9x/hGrqH/3namRFbNo
	fVSnxA2jIy8/WOC60dpjLB6Y9Cn1yN05xC2oDZjZC2WAIj5xBdrH1Pn8yJjFz+qcGt38cYDSd3a
	DOgoSmy9SHjXGnipyEiWsH3Swl56unWCTZ9wn4MSKyG2uWlO1if5DaRWm+iUCPnA5SkN6VPapuI
	VxaYJpqCayVdURWV2KUccFu0r6BN37Omjy3kPueffUHBvUXpS8gPGeCHpVYySzyjdB4f8h8gWPw
	UK5w01wyX7gC2ZrNcw5bhmeaufgInLaNAmnSZV/qzEBRjPsaCjB57t0iS9ICe0Bi2wJAc64vqje
	tUXpY8vFu1ILC4fhPkpZn16gCRAxU/1zcaH/G3QiDdu+1y9553LGTVOnqN0XHkzaD4ghUlbUaYJ
	w==
X-Google-Smtp-Source: AGHT+IFwTwTOglfCAcnv2eeIJKbKLKoLeYRBKMVD09UkBscMOUOH5n7kgqBF6beeLtv4Tcs3gbZbaw==
X-Received: by 2002:a17:902:db0b:b0:264:70da:7a3b with SMTP id d9443c01a7336-290cb27af60mr170024945ad.49.1760934087485;
        Sun, 19 Oct 2025 21:21:27 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec14e9sm68762035ad.9.2025.10.19.21.21.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:21:27 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 02/10] dt-bindings: riscv: Add Zalasr ISA extension description
Date: Mon, 20 Oct 2025 12:20:48 +0800
Message-ID: <20251020042056.30283-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zalasr ISA extension

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf534..100fe53fb0731 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -242,6 +242,11 @@ properties:
             is supported as ratified at commit 5059e0ca641c ("update to
             ratified") of the riscv-zacas.
 
+        - const: zalasr
+          description: |
+            The standard Zalasr extension for load-acquire/store-release as frozen
+            at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+
         - const: zalrsc
           description: |
             The standard Zalrsc extension for load-reserved/store-conditional as
-- 
2.20.1


