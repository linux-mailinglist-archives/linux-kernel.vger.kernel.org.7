Return-Path: <linux-kernel+bounces-809136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B6BB50910
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B451B27DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262928369A;
	Tue,  9 Sep 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4ysR8NN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C52571A5;
	Tue,  9 Sep 2025 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757459347; cv=none; b=MAPmp4Ul5MaJW+Q6cbFIbHeQ1twxPuQFBc5I7GwAHOHGmImJAkD3KoXj+0o2hgzej+Ivr5mZXgaLfFr8Sg6HIdne1uRb8FTRuKExa5M+bNIVjbH82v6sWVPSjym+BJ3Xik7fH7fWRZa7nxSULrY2iF42X83EkhFVNDiIQsI5YuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757459347; c=relaxed/simple;
	bh=X4MgtKTATrL5i+a2AAbV55RNW1mWPBi3lK6FRDpfT0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alg+wjnXmbJ0d/BDC7NQAkxuH1w47LHpEEevcdsP3iBVXrIo/yca4kBDnB2YjXVzSmFRVZDUr32B62B6IuvL3rZzQuaPFMmlxXxTpy8NIvyJZSDn8azjbGicx4nQGLC77zcc2PowtisDYyxQQtye6ozScEbJwZvluzOHJVQzrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4ysR8NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C34C4CEF4;
	Tue,  9 Sep 2025 23:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757459347;
	bh=X4MgtKTATrL5i+a2AAbV55RNW1mWPBi3lK6FRDpfT0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O4ysR8NNdTEu+Arui/n0RNJP13chl4Zn4LfxGrzSNDwxrixdWwgGqRDFikrUAVw3m
	 Ghml8tEP08uqybByE9ENWKDUpF726/d2sxddrPV8DiGidt6f3QwuhYa4UJ4lUiVQsH
	 609PIbZvkF3nQdhmUsZUZba0ZZVgCIShU2l2SGg7CSlC3U6jH5DbG17MuL/mdLigxm
	 SGhjcUCKUI7KqKxPwpDC8QQyvmUUP9Vrg74bEqrP4HQmtfSJkFHNe/XHtUQaGshcja
	 BKNyw7n5mI0b+Z5RLpKO1z7mU+Y17aBYhYOfOvt255PwdVmEy5e4gnPMhhiYR4gKVW
	 rn2rofYVNEvDw==
Date: Wed, 10 Sep 2025 01:09:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250910010903.5388bffc@foz.lan>
In-Reply-To: <5dc41508-43e8-4e80-b4e0-149af7bbdf19@infradead.org>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
	<20250909215824.1968220c@foz.lan>
	<5dc41508-43e8-4e80-b4e0-149af7bbdf19@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 9 Sep 2025 14:06:43 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:
> > Em Tue, 9 Sep 2025 00:27:20 -0700
> > Randy Dunlap <rdunlap@infradead.org> escreveu:

> >> +.. kernel-doc:: init/kdoc-globals-test.c
> >> +   :identifiers:
> >>
> >> The html output says
> >> "Kernel Globals"
> >> but nothing else.  
> > 
> > I usually don't add :identifiers: on kernel-doc entries. If you use
> > identifiers, you need to explicitly tell what symbols you want.  
> 
> Well, it worked/works without using having any identifiers listed, and
> the docs in Documentation/doc-guide/kernel-doc.rst says that they are
> optional:
> 
> identifiers: *[ function/type ...]*
>   Include documentation for each *function* and *type* in *source*.
>   If no *function* is specified, the documentation for all functions
>   and types in the *source* will be included.
>   *type* can be a struct, union, enum, or typedef identifier.

Hmm.. looking the entire logic:

        elif 'identifiers' in self.options:
            identifiers = self.options.get('identifiers').split()
            if identifiers:
                for i in identifiers:
                    i = i.rstrip("\\").strip()
                    if not i:
                        continue

                    cmd += ['-function', i]
                    self.msg_args["symbol"].append(i)
            else:
                cmd += ['-no-doc-sections']
                self.msg_args["no_doc_sections"] = True

I suspect that an empty identifier could be raising an exception.

The right logic should be, instead:

-        elif 'identifiers' in self.options:
-            identifiers = self.options.get('identifiers').split()
-            if identifiers:
-                for i in identifiers:
+        elif 'identifiers' in self.options:
+            identifiers = self.options.get('identifiers')
+            if identifiers:
+                for i in identifiers.split():

(tests needed)

Thanks,
Mauro

