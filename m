Return-Path: <linux-kernel+bounces-879510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57126C23468
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46095189B439
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496C27147D;
	Fri, 31 Oct 2025 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVUUVvQZ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47992D0C70
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761886616; cv=none; b=ogwBWaenpOjnW5kJbjxU85V3NB5qVpsbTBeL26kO1qOdk8mCbMwFkFVK1H4NtbclpKULnbYpWXqNrOvhNefSyQhpILntNiKR108iKB3QwD8M4x9mynWHZEdSdfZTSvYlPSe3+iAf55ZtgJO7r8ZALyDEAOSzU8y5uykTkORizJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761886616; c=relaxed/simple;
	bh=RXiIl8QHy2RQmDekiRS+ZJE4djwIoThOX41hbOUjqNo=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=YsytTAR0G0E53V23dibjTlTlQX8BcjgBRCfBvTizzJ/cEP6IIY5VpicxurO10W20QfcpcU28V2SoT5LNIH67W1+9cb47UZbI4avB1i/ONL8LP3tCnh7guM63BfxBfehRNKI4KIatyiL7ts3Nfa47aJldIpmuuuNS0S6N9/GTKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVUUVvQZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429c20ac820so39341f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761886613; x=1762491413; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3m8aq/RrYHBIP7bSVm+Q0EOZW0+wlH0W2+b0O6JlKU=;
        b=dVUUVvQZpVBRdix2o9qf08yA5A/zChGeTo+jjcpKMRUqQGK7ZH1xpuivJdNHHb4bCD
         hDCvLLUB4sZ7TTYzK7SbQRygxZzHBY2W0H8uSC3HBhlCZ04oD8SJ7eyuwicjg7nOrXqI
         GwrufQwr+EdFC9om6huDivDbCVznZ0JOnIV4CwWsLi/H/b08fsF3qdZpIdImNNoHMwSX
         PAzCisFMNoq5uaGKpqhtnL8ekpGz8kXy47G1BjqS1eD/CbjDUzEi2GUnl13NPSyCGO+5
         ss4A0XkLi9vnVax8ucaSsxrk3SlUmBQYoJUnl2aAXD9FQjkzUnYqnNOQLQt22YaiLyaF
         ixMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761886613; x=1762491413;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3m8aq/RrYHBIP7bSVm+Q0EOZW0+wlH0W2+b0O6JlKU=;
        b=hsWzfBOLMchTSUjwP2O5I4sEGUyYl5/hpxLg9HbfRgiEXJwm3CAaCplGQUw/in6Zem
         LRP3f9ytrdDx2Ci0nye9ryjw/s6Z4kE/JsGjPJo+CYqBugfmogW8bMyxGNnjL+vFznjO
         VbkiPwKiAYWkJVT/7TqQCNVoXUqLER9gkIyvp+49MR76XFJHKbjEMIk5kYk1iLNafKc2
         fWt4WMgdTSgh39DFXx6S7dtoE2fQlhO9uZQGvDsDTMQVN0Mu1nb28kefImFVI8qFBpGv
         dJqxZcXhiVQvEHtW5gHJKPPxDYPOLfZ3xr4annrvmb/09jcHpYL5CHHTh4vbfQ8i1eg0
         7G3g==
X-Forwarded-Encrypted: i=1; AJvYcCV+gcokhhUObPXyHnAKqsXk67cSK3Fsux68yxMZzpQzFX6dvJPe8gazeHhcfTTnlY7FS1tMY0Z8VHTTFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+H+w3/dVxq19YTJhiTsGgnhKThWNn/o18rieUkuv1kjVSxjav
	v0tuphaas9py209puUx+/pRVH/ZomnxVXBZ4CiWw+HXf7AeadDSm1ct+
X-Gm-Gg: ASbGncuQMaCJDkofMP5CgFqQ070fg5z7WA4P/XwLrj2z7X/3+MbLVL8AriZ0J92fipG
	boMQ4BamWMtg1/Dkn1rLLWlD3MSVHeKbloonK3rSy2SWGOFcbLXdWu6WzHZf/gBFLjDCUVXSvIs
	m3DNec8VRs2ozQAfiMULmLma2XkE4dgL9AwBicAdNlNXic3Cmbodlj8TSrc2MiVF5/vqfqmVClx
	m0VXlRL5F8TpDquEjW9thT1bMFx9f3S5KU5R0Jdu18qpyF5MJ+SETVi4Ku9M5SxDndTcfR9hKZg
	RbW++3lzt73oj3la/ETS0nhALwKZcvNroTHwIYwCfN4jpdDpp+8vuZlCbsdhTiqMxgMCZUC6htT
	6XrZ7wBTgqEBGYDr4oIRIruuKBwJlFYLEEMnXZfOw4Csv3tjZ1m/ChxlXwLy4oQ2L8eRf+MIFdw
	tOlAg=
X-Google-Smtp-Source: AGHT+IHZJzakzTgwlQHrJ/hVyQ/JzPNqC0OXG+Lg3olvwUpspwRFjhHXnZ1HB94EgEI14GhptLth7A==
X-Received: by 2002:a5d:5c89:0:b0:3de:b99d:d43 with SMTP id ffacd0b85a97d-429bd6895ddmr1557063f8f.19.1761886612883;
        Thu, 30 Oct 2025 21:56:52 -0700 (PDT)
Received: from [172.23.94.183] ([147.161.143.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c112413esm1351004f8f.12.2025.10.30.21.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 21:56:52 -0700 (PDT)
From: HariKrishna Sagala <hariconscious@gmail.com>
X-Google-Original-From: HariKrishna Sagala <hkrishna@gmail.com>
Date: Fri, 31 Oct 2025 10:26:02 +0530 (IST)
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
    kuninori.morimoto.gx@renesas.com
cc: shuah@kernel.org, david.hunter.linux@gmail.com, 
    linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] ASoC: soc-core: proposal to remove num_auto_selectable_formats
 from snd_soc_dai_ops
Message-ID: <2daa603f-13fe-c803-17fc-4fdd8e5723ba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-437433266-1761886612=:1037"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-437433266-1761886612=:1037
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Hi,

Good day.
I¢d like to propose a small cleanup and simplification in the
snd_soc_dai_ops structure by removing the
"num_auto_selectable_formats" parameter.

Context:
Currently,snd_soc_dai_ops includes the "num_auto_selectable_formats"
field to indicate the number of entries in the "auto_selectable_formats"
array.However, this count can be derived programmatically using the
ARRAY_SIZE() macro wherever needed.

Proposal:
Remove the "num_auto_selectable_formats" field from the
snd_soc_dai_ops structure.Replace usage references to this field with
ARRAY_SIZE(auto_selectable_formats) in the relevant code paths.

One effect I see is if the parameter "auto_selectable_formats" has
only one priority format because few codecs are defined as a u64
variable,will correct and prepare a patch.

Please provide suggestions, objections and also to consider any
compatibility problems,historic importance of same.

If there are no objections, I would like to prepare a patch for
the same.

Thanks.

Regards,
HariKrishna.
--8323329-437433266-1761886612=:1037--

