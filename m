Return-Path: <linux-kernel+bounces-849378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1A2BCFF6B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 06:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6371894650
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 04:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462F1FBEAC;
	Sun, 12 Oct 2025 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5DuDNMC"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC478135A53
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760243975; cv=none; b=o7eEuoT9jmK480M53sDuWf2F4GEURgMOAAW2g+K8W9O1W+yaaF5zElG56sD1M4FL73enPRVfkYcJT7qPfwtVJ8xUfCZGPnA+w9HhWWFb50i1aqMnyEJnwgJuyao47HjgoAaABNVbuG4ytPCj9hME6oLEbhG0cpGHysOkzXoR314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760243975; c=relaxed/simple;
	bh=i0NB8VPs9WNZNzuJ91iOWkqGkMr0ANpgHpdXj94FyrE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XXy7e4wpi8LuMOF8pTA6tJWsjH9S/JjNuQJG90FXbcTqEDXvzL11fEpGBKETvyRcv4SIbE32gJwZbL3jm0G93bzmExoFUs2V/+yRzsHeHzuvAOCuSh5UZcXgFUeoZecXW3YX0DchsN6+F9JyvlKKAAdbWBUXJyVKnYx49+X0EyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5DuDNMC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so3322894b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760243973; x=1760848773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DUhac950eRxdyyx3HiUQwDUj821eiw/vdCCJuggJU0=;
        b=e5DuDNMCCMH/2mZW42cr1nemGHTE3vP+kakvBtP9NhsY89GoPWUSQa2L9NtPtmzbNh
         mVJmT3X7LTJDw+QQoQDm65OtsWJg2FsBITvLERbx/+sqY5a4VgpFf2qc3wPxELvsZSbN
         HpQmlFvrhG86BscEZFJneqtjpgE61GvEFhue8JqntGx75/amZU3ed3Co19mEtCoiXWyD
         6PWIyH09Xctw66YKeg31HpKpZ3zNED9GAK5+JNSFrwdwoVBgI0eQaF8X5hP1GE1czMj4
         xivzZ0epCVOOFDdSxr+nLCJLTUKaPUG85euphRx0mf2jYSSVTPBvShCNVUrYK5JKfhnu
         XcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760243973; x=1760848773;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DUhac950eRxdyyx3HiUQwDUj821eiw/vdCCJuggJU0=;
        b=wlmXtHA8lEAYHO+HxVqDDTcDkoVIo8QTU3u/ZNN6I5Vc05kVj6ecHkTB96KgPDpCcO
         cztyGovZw0AytVVKZ/4DWRnpPSnglMnFsWt17EZbQZ5MKQipO8mjBhFJQo8QNy36+xjY
         I+RiPyO3oYdwj3KuFSbv0keAUNHP82DJExAryrujYkkeJC7PrOeENGr3SM2k8OGGCFVE
         PRH+by66FHCMPalC2qLPNn04JNi0o6takYo/skwx4FOzq9eqhAxOvK34d4BOb04VlvBO
         R8oU/woLVwMIC4wqUVG3Gpd4GXju7qJvP24ZFBeTu8dPlFryZEcXngF2ayp/lsgdL65X
         YMqg==
X-Forwarded-Encrypted: i=1; AJvYcCXWi9UFDHHwgg0GUo/DVwu9tPRl9431b/cwecK+eSKTpEyBS9ccqoqENEH6JoHgfneOxGR/71viUa/o6lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbqEP9sUFabZ4EbgBXWZr9vPcbC4ysWCepEumTMpMKfevRD3c
	NcJypr2raHQstWC4I/yka1MJcjnyP3AnbMdEu8kx6FvIN9h4/PBvbwv+
X-Gm-Gg: ASbGncs/AI1z8/CV0IBtLO6V3SZ9DCb02x7kV9Io0FFt/EL3Q2q+HNB9VtjDOVESag3
	trzti1UNnA/w79L7sXd9zgc0rMfXRefrKdtMIncvdYN/RVzTGInDBqeANcSmJeesCrkknGGGGyO
	ndYypi0ulRgeDn7Y2aLBaScnWxqWoSWIU8X7+j3WKOOBn+l1O3wfmuRE++V0rcZpSHPi6ZWYn5E
	DbBKw4n0RAZcJoHNRjcbzJsjTTNQHdvxLuA0WF4wDDIu3F8NLBAqHLXqxukAjGizYvxVTGF82Ib
	UE/xYRw11CtePSzajkVWNIfTDtrCSC6oiN4KnJT/hppMmf6liPGrhQNAkQ8RYnzEMcq/nFQg9s0
	EEnB0tXJmEezN8V3wLFWbFHsJHP96zfnLVS5fwbkSc5IGgT1HOFAX6CICqN7QqfvhGkorXdHKGl
	azXPacYokmYoI=
X-Google-Smtp-Source: AGHT+IEVrJIqHvqdRDlLJG5jsbGyIWUy4NaEqCqD107094NHNTnFue4xGwAElpPMyo9ce8seoro+QQ==
X-Received: by 2002:a05:6a00:1701:b0:78c:a3a6:a1bf with SMTP id d2e1a72fcca58-79397b19445mr19301172b3a.7.1760243972914;
        Sat, 11 Oct 2025 21:39:32 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm7453159b3a.18.2025.10.11.21.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 21:39:32 -0700 (PDT)
Message-ID: <12aa7858-b05b-415f-a76b-c18848a9a784@gmail.com>
Date: Sun, 12 Oct 2025 13:39:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: nogunix@gmail.com
Cc: chao@kernel.org, corbet@lwn.net, jaegeuk@kernel.org,
 linux-doc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20251011172415.114599-1-nogunix@gmail.com>
Subject: Re: [PATCH] Documentation: f2fs: wrap tables in literal code blocks
 to fix LaTeX build
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20251011172415.114599-1-nogunix@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On Sun, 12 Oct 2025 02:24:15 +0900, Masaharu Noguchi wrote:
> Sphinx LaTeX builder fails with the following error:
> 
>   Markup is unsupported in LaTeX:
>   filesystems/f2fs:: longtable does not support nesting a table.
> 
> Wrap the ASCII tables in literal code blocks so that they are rendered
> as code instead of interpreted as tables. This fixes pdfdocs build
> failure.
> 
> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>

With this patch applied,
"make SPHINXDIRS=filesystems htmldocs" emits following new warnings (Sphinx 8.2.3):

-------- -------- -------- -------- -------- -------- -------- --------
<srctree>/Documentation/filesystems/f2fs.rst:307: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]
<srctree>/Documentation/filesystems/f2fs.rst:308: ERROR: Malformed table.
No bottom table border found.

=========      =========== [docutils]
<srctree>/Documentation/filesystems/f2fs.rst:309: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
<srctree>/Documentation/filesystems/f2fs.rst:310: ERROR: Unexpected indentation. [docutils]
<srctree>/Documentation/filesystems/f2fs.rst:311: ERROR: Malformed table.
No bottom table border found.

=========      =========== [docutils]
-------- -------- -------- -------- -------- -------- -------- --------

That said, for your info, in-development Sphinx 8.3.0 (not yet released)
has a lot of improvements in its latex builder including support of these
nested tables [1].

So, I think one option for you might be to wait Sphinx 8.3.0 without
these changes.

One caveat is that docutils 0.22.x is not fully compatible with the latex
builder at the moment.  If you'd like to test Sphinx 8.3.0, you need to
say "docutils<0.22" in pip install.

[1]: https://www.sphinx-doc.org/en/master/changes/index.html#release-8-3-0-in-development

Hope this helps,
Akira


