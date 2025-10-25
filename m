Return-Path: <linux-kernel+bounces-869974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B78ABC09283
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033274E1167
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900A302172;
	Sat, 25 Oct 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnri/XJF"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167702FFDCF
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761405266; cv=none; b=iLxxjLvMBNI59ltcQQgBa9MzV4tg2Rc6cgmFG3OPnafW2mHld7MZN+IbrZXMHkn6ySyEPhhy9Z97c+E9r0sXgAQRzEp3Jb97n0BXp+Pu0RSeE/wxLalBShfB3LgvwvAF8y/j3g9Bps9DRbTDHxT+mrgQUhXKrWSg4twNBYyVwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761405266; c=relaxed/simple;
	bh=QAv9wnda7g3m75rjqRt1OT7ex6pWUA04I2r6oecL4yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4cyCmgl5EIAP3SYn6IFkatGI5EKwlpq1yOvFvDu0CK1zCmoPeklR/Qg36hRXeHPfZUb98FMvdr6jYBffe/jb4+cj1DA+8UULUi1mUb2RhjkcGEtZbhQCZJ6PDd9lzfg5Tq3p6ZnOXEA09Syo6FiZXe++m2JCHjmbVHCwJvAccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnri/XJF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2543478a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761405264; x=1762010064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4QbhlCobjLz18WKX8IPz8TGhcE8DFK2aHPkOURXrxw=;
        b=lnri/XJF8h/VA2LnnBT8eAlu4DCm85OUTHF1niCNz2SOEcFHQGI+Yca0CddP/vNhlS
         W4opxC/C9IOIwCPUI1o43Llt26mzou8mJqBXE6XEg4ekMSh9j3SA8zG6LM8rd+SFGAu9
         S2l6UKZYZQGOfMlFFTM0b79UAc20kj/Sd2sE0G9DV0iG0bYvwbzWPcqgxj/reJ98DeqY
         3LyqQRvf6WD40n3rDThiT+Xbi7bY2w4NKWlIznAuXpithF0uXdTa4eV1Ia3d0/CCqu11
         NzynTY5cs7gxEB9X0noPDhK7M3q6D2jbdzjrX0WZYT7wVZMQ2ocMYx+RJiEBsFl7sqYG
         aahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761405264; x=1762010064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4QbhlCobjLz18WKX8IPz8TGhcE8DFK2aHPkOURXrxw=;
        b=mnpYiYv2IUstjO6i8pefcpgk0sAYeq8+YrLgvnd5TPOR1sf3E/H3tHMuOcYkK0AMU/
         hhCWSDYzyQLC1wlYoQlAEMQlIaVK7FB8Z6mrKlPX4xJB9a2nAtoXv+C9Nk2Z532w95gE
         s7gcGcJ4m1qlnGwkwsgCL9tgIb1pIMdjFXlyUE7anIDEiDzVwYrPtZzl+rsmvm3fYPvr
         O7MlXJYv6sN1jlxOXkrcK3s2hGbSQw8555joix1cJ0h2JFRk3Er8LjQIuXTKMRG8Dfas
         1MJuiwyPU9tzzK7I+CDEYuXytX9CtWCqca9wT1Zcbnnsj2GXH20zxnSYGdkMX1h1cDj/
         B/Xw==
X-Gm-Message-State: AOJu0YxigevVY1RNu/4gxBPdpay5vSXI49egvk+21wyRSO/avIlGI9iw
	jT6kByMpKi0w7pqYI1pBRM7fO3j3xk9BKjYq6wTYluU3WaPQMjsQshIC
X-Gm-Gg: ASbGncuXfhNAU9nGAqGdP8563meTENDKaHP0ybLVthPGnJgZVjmot/Z22uGwaICWmxy
	Bu4v6+NOpINp9pPo8mgiOsx/egFr2tizbnIaa0QrcYbc6ACsFqcK3fH5Eckg2WXnJg8c21XR//0
	cS52tcs28Qt+T8r72CPUqt0IQJ77ocPK1xwYFivaOM1bN3MMCKmJpSKKB5EHkYXjxeKPiyizhvb
	AA8C8egpXZBTW6S7uU4RNhv7hExhtJPQIpqIzosplKnFIBQGlEsFicmxgO2d6YUEje0OjG6Z698
	AThhSVX/+y1UDfRL+/a+X25mOvUKZtXUcn5HXsvRhTmoVG3ywLmye566uSduxRPWCWR9zpXtsCe
	YcSR8kp1LKcsO2epEfJajjZE0LwzwQvUEs1MZaeg3HXg31N9PwTqk7KfKMeox1WuLbd0yR82aju
	DXIwqPGsixrFE3hjbe9Vb2rSt8m7uqXfr+xwNKKETwNvxU7M3F2EXv5XAglSQTSdI7f5k=
X-Google-Smtp-Source: AGHT+IHJPSP6jbM7wZQLFD7UH7DCxuWGCNk1Y6bwxxYjjMYdwYnT3N59e8lkDwguqze1YiD3++BZyw==
X-Received: by 2002:a17:902:dac6:b0:290:b158:5db8 with SMTP id d9443c01a7336-290cb65b668mr449750345ad.44.1761405263942;
        Sat, 25 Oct 2025 08:14:23 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d30030sm25882705ad.65.2025.10.25.08.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 08:14:23 -0700 (PDT)
Message-ID: <d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
Date: Sun, 26 Oct 2025 00:14:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, Akira Yokosawa <akiyks@gmail.com>
References: <20251024200834.20644-1-corbet@lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20251024200834.20644-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 14:08:21 -0600, Jonathan Corbet wrote:
> Our documentation-related tools are spread out over various directories;
> several are buried in the scripts/ dumping ground.  That makes them harder
> to discover and harder to maintain.
> 
> Recent work has started accumulating our documentation-related tools in
> /tools/docs.  This series completes that task, moving the rest of our
> various utilities there, hopefully fixing up all of the relevant references
> in the process.
> 
> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
> 
> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.  I would propose either tools/python or lib/python;
> thoughts on that matter welcome.
> 
> Changes in v3:
>   - Now with more caffeine! Properly based on docs-next.

:-) :-)

WRT the build error from test robot, it looks to me like we need these
final touches:

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 8e3df5db858e..fbd8e3ae23ea 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -582,7 +582,7 @@ pdf_documents = [
 # kernel-doc extension configuration for running Sphinx directly (e.g. by Read
 # the Docs). In a normal build, these are supplied from the Makefile via command
 # line arguments.
-kerneldoc_bin = "../tools/docs/kernel-doc.py"
+kerneldoc_bin = "../tools/docs/kernel-doc"
 kerneldoc_srctree = ".."
 
 def setup(app):
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 2586b4d4e494..3c815b40026b 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -289,13 +289,8 @@ def setup_kfiles(app):
 
     kerneldoc_bin = app.env.config.kerneldoc_bin
 
-    if kerneldoc_bin and kerneldoc_bin.endswith("kernel-doc.py"):
-        print("Using Python kernel-doc")
-        out_style = RestFormat()
-        kfiles = KernelFiles(out_style=out_style, logger=logger)
-    else:
-        print(f"Using {kerneldoc_bin}")
-
+    out_style = RestFormat()
+    kfiles = KernelFiles(out_style=out_style, logger=logger)
 
 def setup(app):
     app.add_config_value('kerneldoc_bin', None, 'env')
diff --git a/Makefile b/Makefile
index d6ff0af5cca6..33b1db1cc0cf 100644
--- a/Makefile
+++ b/Makefile
@@ -460,7 +460,7 @@ HOSTPKG_CONFIG	= pkg-config
 
 # the KERNELDOC macro needs to be exported, as scripts/Makefile.build
 # has a logic to call it
-KERNELDOC       = $(srctree)/tools/docs/kernel-doc.py
+KERNELDOC       = $(srctree)/tools/docs/kernel-doc
 export KERNELDOC
 
 KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \

-----------------------------------------------------------------

The change in Documentation/sphinx/kerneldoc.py is needed because

    kerneldoc_bin == ".../kernel-doc.py"

indicated loading it as python lib into the extension, while

    kerneldoc_bin == ".../kernel-doc"

indicated invoking it as a script.

Now that we don't have kernel-doc.py, loading python lib looks to me
as a natural choice.

Mauro, what do you think?

Hope this helps,
Akira


