Return-Path: <linux-kernel+bounces-809379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB2BB50CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E134E87EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC902877F1;
	Wed, 10 Sep 2025 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntc5FemF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58C8248C;
	Wed, 10 Sep 2025 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757478209; cv=none; b=VXoXtW8dVCQGV9O8/gPI2DJhZBPu3KwhXX07zKN8plCG6aExCYGAh4A3aYW9NGoUibUqNJBgPzDpPXcpVVazbSx3S5C2vnr9/R4KaFBvm8FTbO2UYFvKnJKtrOL1yfKD9QO2lzACm5T+ufm6/2Ejh9HS3Si8btH8NtffYrDi4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757478209; c=relaxed/simple;
	bh=rE8gJPwTFV7yXLUljHlupB2t0ikdiGeonTdVcLTIHsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q29EkVKCfwsMmjseezcyttCdJGafiBOo/NxFyiQnzWaZWcoER2bbTBEnQ6obEe6IwYdOXs59+ctlQ8HjEotT6cnCuWB/HKycW7xlLx4VnqZoNO1J0WB/vrW9AncSHgTXuDGzOh8Kw5sHqUShv861zGIs60yv983lt6iB3+Iqz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntc5FemF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FDEC4CEF0;
	Wed, 10 Sep 2025 04:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757478207;
	bh=rE8gJPwTFV7yXLUljHlupB2t0ikdiGeonTdVcLTIHsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ntc5FemFlZh2pP3IxVGJVZpGv2GGSe19vt7QsOivy6KqDKXIHHaYDMZcKUYUn8VpJ
	 Ow3nFbm3QXEQ4BUooY6wmXlIjw2yjsfRo95LIOSistM4xwI6Mvij49ijaJclU8ky1b
	 YFdPhBLGlOp2JLwEaHj8/ypOAX9S5eJtgfEQiDEo8SVsoUxZVonOuho0EKbjbVxP0k
	 RHknYfLEUbPrYVlOEjHwZK2l7VdWMpLce6PuCdeP0LeIwnzhbmOHOZxUkvTo8jml8Y
	 1TgITq+fAXUVYG2WkxbpjfPT9vk3LzfUvv+h0wfpxvQ20JweZIphT32MvLmr/p2uIT
	 bBE81EtsxOqgg==
Date: Wed, 10 Sep 2025 06:23:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250910062323.059bb078@foz.lan>
In-Reply-To: <c195c68f-e815-4428-9134-8746198a4611@infradead.org>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
	<20250909215824.1968220c@foz.lan>
	<5dc41508-43e8-4e80-b4e0-149af7bbdf19@infradead.org>
	<20250910010903.5388bffc@foz.lan>
	<0d190bf0-b9d4-4d5c-a1cc-6d5d79be3886@infradead.org>
	<656591ff-fa7d-4763-8759-0a0af3a4039a@infradead.org>
	<c195c68f-e815-4428-9134-8746198a4611@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 9 Sep 2025 17:02:00 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/9/25 4:50 PM, Randy Dunlap wrote:
> > 
> > 
> > On 9/9/25 4:49 PM, Randy Dunlap wrote:  
> >>
> >>
> >> On 9/9/25 4:09 PM, Mauro Carvalho Chehab wrote:  
> >>> Em Tue, 9 Sep 2025 14:06:43 -0700
> >>> Randy Dunlap <rdunlap@infradead.org> escreveu:
> >>>  
> >>>> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:  
> >>>>> Em Tue, 9 Sep 2025 00:27:20 -0700
> >>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:  
> >>>  
> >>>>>> +.. kernel-doc:: init/kdoc-globals-test.c
> >>>>>> +   :identifiers:
> >>>>>>
> >>>>>> The html output says
> >>>>>> "Kernel Globals"
> >>>>>> but nothing else.    
> >>>>>
> >>>>> I usually don't add :identifiers: on kernel-doc entries. If you use
> >>>>> identifiers, you need to explicitly tell what symbols you want.    
> >>>>
> >>>> Well, it worked/works without using having any identifiers listed, and
> >>>> the docs in Documentation/doc-guide/kernel-doc.rst says that they are
> >>>> optional:
> >>>>
> >>>> identifiers: *[ function/type ...]*
> >>>>   Include documentation for each *function* and *type* in *source*.
> >>>>   If no *function* is specified, the documentation for all functions
> >>>>   and types in the *source* will be included.
> >>>>   *type* can be a struct, union, enum, or typedef identifier.  
> >>>
> >>> Hmm.. looking the entire logic:
> >>>
> >>>         elif 'identifiers' in self.options:
> >>>             identifiers = self.options.get('identifiers').split()
> >>>             if identifiers:
> >>>                 for i in identifiers:
> >>>                     i = i.rstrip("\\").strip()
> >>>                     if not i:
> >>>                         continue
> >>>
> >>>                     cmd += ['-function', i]
> >>>                     self.msg_args["symbol"].append(i)
> >>>             else:
> >>>                 cmd += ['-no-doc-sections']
> >>>                 self.msg_args["no_doc_sections"] = True
> >>>
> >>> I suspect that an empty identifier could be raising an exception.  
> 
> and it's being caught and ignored (not printed)?

there is a try/except block to capture exceptions. It is supposed to
print something, though:

        try:
            if kfiles:
                return self.run_kdoc(cmd, kfiles)
            else:
                return self.run_cmd(cmd)

        except Exception as e:  # pylint: disable=W0703
            logger.warning("kernel-doc '%s' processing failed with: %s" %
                           (cmd_str(cmd), pformat(e)))
            return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]

> >>> The right logic should be, instead:
> >>>
> >>> -        elif 'identifiers' in self.options:
> >>> -            identifiers = self.options.get('identifiers').split()
> >>> -            if identifiers:
> >>> -                for i in identifiers:
> >>> +        elif 'identifiers' in self.options:
> >>> +            identifiers = self.options.get('identifiers')
> >>> +            if identifiers:
> >>> +                for i in identifiers.split():
> >>>
> >>> (tests needed)  
> >>
> >> Sheesh, I can't find that code so that I can patch it.
> >> (in today's linux-next 20250909)  
> > 
> > oops, I was looking in scripts/ and not in Documentation/.
> > got it.
> >   
> >> Anyway, does this take away something that currently works?  
> 
> The output looks the same with this patch AFAICT.

run it in verbose mode to see what command line was passed to
the file:

	$ make SPHINXDIRS=your_test_dir V=1 htmldocs

This should be printing how the kernel-doc.py command line would be(*):

	scripts/kernel-doc.py -rst -enable-lineno ./include/linux/peci.h
	./include/linux/peci.h:20 Scanning doc for struct peci_controller_ops
	./include/linux/peci.h:32 Scanning doc for struct peci_controller
	./include/linux/peci.h:58 Scanning doc for struct peci_device
	./include/linux/peci.h:88 Scanning doc for struct peci_request

(*) the kerneldoc.py extension doesn't call kernel-doc.py, but instead
    run directly the Python classes from the library. Yet, to help one
    to debug it, the command line is displayed.

for instance, on a more complex kernel-doc tags case:

	$ make SPHINXDIRS=driver-api/cxl/ V=1 htmldocs 2>&1 |grep scripts/kernel-doc.py
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl pci' ./drivers/cxl/pci.c
	scripts/kernel-doc.py -rst -enable-lineno -internal ./drivers/cxl/pci.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl mem' ./drivers/cxl/mem.c
	scripts/kernel-doc.py -rst -enable-lineno -internal ./drivers/cxl/cxlmem.h
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/memdev.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl port' ./drivers/cxl/port.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl objects' ./drivers/cxl/cxl.h
	scripts/kernel-doc.py -rst -enable-lineno -internal ./drivers/cxl/cxl.h
	scripts/kernel-doc.py -rst -enable-lineno -function add_cxl_resources ./drivers/cxl/acpi.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl core hdm' ./drivers/cxl/core/hdm.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/hdm.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/cdat.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl core' ./drivers/cxl/core/port.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/port.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl core pci' ./drivers/cxl/core/pci.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/pci.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl pmem' ./drivers/cxl/core/pmem.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/pmem.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl registers' ./drivers/cxl/core/regs.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/regs.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl mbox' ./drivers/cxl/core/mbox.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/mbox.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl features' ./drivers/cxl/core/features.c
	scripts/kernel-doc.py -rst -enable-lineno -function 'cxl core region' ./drivers/cxl/core/region.c
	scripts/kernel-doc.py -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/region.c
	scripts/kernel-doc.py -rst -enable-lineno -function UAPI ./include/uapi/linux/cxl_mem.h
	scripts/kernel-doc.py -rst -enable-lineno -internal ./include/uapi/linux/cxl_mem.h


Thanks,
Mauro

