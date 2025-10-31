Return-Path: <linux-kernel+bounces-880430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56229C25C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C81887165
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1E286415;
	Fri, 31 Oct 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PBv7i/jF"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BB278E44
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922148; cv=none; b=dLEz6tt6B3WrVgbrFC3QfvX/InWbV8eImh8XYN5yIfr40legL8OlZRkQ4tnIqbAI3UyX7QPCx+TUEqKdw9V+dr9AcTG+408rOTbdkohSSjn6UFnf1pEbKZEVa305eU+VhDu8QKNDYZqVixd4MOOZFV7O8+BImw0Rv7Oi1TDg3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922148; c=relaxed/simple;
	bh=ATm3lmVuytdNqKpLDBCWHD+5ybDdtQmLdxvCyuvui0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLFusZYg5M8vz6ao2lXPcrok7KIHtjYQq4BXRO8/mk0RE61c9DbyNXoQzUKGSuWRXFY8YUg0VsFrMt8I2K+WlzklfiQ0gL4hru/nq/miRkoFcOUke2b3H9J+eRlG8hyfwPr761z5A4f9QYjVVwkWPawVH7aPeezqKEkVC65OS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PBv7i/jF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b95cdcacd95so97385a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761922146; x=1762526946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8KBeMeYUon6BQraYtudMUHNR0dTqRE5CF3A2DrTv9E=;
        b=PBv7i/jFwQA6YF8ymj69WiW+5U6yB4wKTM+txIxCmLJ6CQI7GpLcfJE+R0DZYyDihC
         JMYXAiuRoD0etHArTfU1H7tnUV1HAyiPOS6mS5vxZb0LG8mna7S9S3nleKHY8P1QpDzG
         LJmv/6PY79L68bxbHA5KsOA6YM/uJHl5J3au/zIErR5k2+TamfDEc8dVmMjwWSQpPaWd
         2WRk+jbqZFGnvTxMBREJcIeGSaImCdLNnjKJAjzVOlxavYIAUjFT0i0+acBC1Jj1Nk7h
         Zt1DKWE+6pcDn3WpOyaBuXM2BJBlyU9XUX7QHlO7KFXXaxMqEHzyTakyFNvssHq/ab4t
         3yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761922146; x=1762526946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8KBeMeYUon6BQraYtudMUHNR0dTqRE5CF3A2DrTv9E=;
        b=n25ijGR8LxM081OAb2DewHoYorSEOxV7wqiQUUP0stQZb+JPxvnOJozZr4XQ2skna8
         6yIL2CmjAAGYTz/xDO0goiVFClCfoyPyedVznQoQLbuFv0rb0w8vh6f08A8NQ9Zs56iT
         ybB01MrrLf6QlPl2i8XepTZQXYXoQWjn07huPR9pGYLkGtjYTecE5zHzdDPyEURNbNK2
         A1pelIS16yvXaRM9/3IZ5vR0pu1KnMs14KIc/sM2omuNbXlJEe8XCKQSWuujk+ZfuxC8
         eGlVL+NXM/q3HCAr6uLLyOHASp+EAtHZ3o/X8tcRrckalED3KjlkLw7tiW10okab8Mzz
         JkXA==
X-Gm-Message-State: AOJu0YxNlKkjBoMVvvWO56VFrOMnmjq3dmxWUS8i3z/vtBxFSMHsk9uG
	fVjqM9EllmWns1uQRskugI8Q4Op86/lE841fGiG/mhTkf5vWupWSy2gXn1GQW7nWLUdzFJmGgXs
	nP2T9
X-Gm-Gg: ASbGnctfrrDf8xsHatVA9RnWVGDF3mcGRl0GZ4Xf8NxQ83KZZxPNNQ2dRPIr2fOjhU6
	VMQeECMp3ym9N0PzM5FkMiiKWKQGmTwd5GFepUIogkbyOLnPcqXCXq+6adcbg8H7A0bf2K7/nwy
	IlTdrA7LE2P3IXyW9k71T1LRC8E5+xJ0K3cS2iTEVhB1fuf4g9a8JrquTTsgnhSCTQmswXEIEhA
	FdokCn2eyqilOxz0dHNw1varR8u7SE2PA1WcgF8gGdxndjNzhQfD+OUw4uR0HqBPL7XuAhIOy01
	gwC8q8mz5XDS536oQZMMcVM/IXrN505gqRmo7sDx5+neLrGcJi3WBQ+/dfSlPFhHKPHMPzDkksE
	34ksUDMOncuV3kceVTIUHBR/rjg92388y7022nG2a45cTChDInNTrvgOmPcdfIwfiIeE3ev+zvE
	87K/rWUmXxiGGs
X-Google-Smtp-Source: AGHT+IHPF2x0DGEn26EwYhqgvCtNpun32sTU7vWqgQS1gMXJpOJKN9HNTpNSlv3IlQSbO5TEaferpw==
X-Received: by 2002:a17:902:d487:b0:273:59ef:4c30 with SMTP id d9443c01a7336-2951a39e2eemr55702665ad.15.1761922146176;
        Fri, 31 Oct 2025 07:49:06 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm26064835ad.105.2025.10.31.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:49:05 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	thomas.hellstrom@linux.intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/xe: Don't use absolute path in generated header comment
Date: Fri, 31 Oct 2025 07:48:53 -0700
Message-ID: <7fa5ef0acc89a9d94c328f6651c1d405bcd833a4.1761920974.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the XE driver through Yocto throws this QA warning:

    WARNING: mc:house:linux-stable-6.17-r0 do_package_qa: QA Issue: File /usr/src/debug/linux-stable/6.17/drivers/gpu/drm/xe/generated/xe_device_wa_oob.h in package linux-stable-src contains reference to TMPDIR [buildpaths]
    WARNING: mc:house:linux-stable-6.17-r0 do_package_qa: QA Issue: File /usr/src/debug/linux-stable/6.17/drivers/gpu/drm/xe/generated/xe_wa_oob.h in package linux-stable-src contains reference to TMPDIR [buildpaths]

...because the comment at the top of the generated header contains the
absolute path to the rules file at build time:

    * This file was generated from rules: /home/calvinow/git/meta-house/build/tmp-house/work-shared/nuc14rvhu7/kernel-source/drivers/gpu/drm/xe/xe_device_wa_oob.rules

Fix this minor annoyance by putting the basename of the rules file in
the generated comment instead of the absolute path, so the generated
header contents no longer depend on the location of the kernel source.

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/gpu/drm/xe/xe_gen_wa_oob.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
index 247e41c1c48d..e7a50b1348b7 100644
--- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
+++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
@@ -195,7 +195,8 @@ int main(int argc, const char *argv[])
 		}
 	}
 
-	fprintf(args[ARGS_CHEADER].f, HEADER, args[ARGS_INPUT].fn, prefix, prefix);
+	fprintf(args[ARGS_CHEADER].f, HEADER, xbasename(args[ARGS_INPUT].fn),
+		prefix, prefix);
 
 	ret = parse(args[ARGS_INPUT].f, args[ARGS_CSOURCE].f,
 		    args[ARGS_CHEADER].f, prefix);
-- 
2.47.3


