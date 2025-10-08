Return-Path: <linux-kernel+bounces-845549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 607CCBC5569
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E93984EAD9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77728A705;
	Wed,  8 Oct 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XXpm8/KN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF142853F3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932116; cv=none; b=UNAHxCCSb7u8x6eoaN9ojeb2pqOi5XtEUVJ2pucQuYaBB+UpYiF+b4TUu5iuIFhlkSz5nInXFs9n7b56FdSnrQ13YvNcJ21JTdHpG99CfXxAbVaFBw7EW2CpkN7ojovexm8n7AkEfts5djeJD7p0B7tqT5T8bh3M+t5vecdsHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932116; c=relaxed/simple;
	bh=yynIpSOLVFVEkI/2gd+WgMM9p4RDpMfRdgfNtj5Lefg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCRIppMz1ZCP8Vkj5VZtdWSqfBVt6xBJVRk5NHry+fCUjxxXKLkIEK8DSdNXAW9ON+dcbUn4TS89KwGjRdPlH4h/K8t9xkHbl3yCHPVCifqLnl+nEj1P5xJk++geMdomYB2NfLDKkVEbgcVGVb6rL0nl1cxf82e6Kmlc8MBaEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XXpm8/KN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1405138766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759932113; x=1760536913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxy47Jf+3YxpTMUbbeFHpZ90+HRxyRlrxDfVlXCqO7E=;
        b=XXpm8/KNAmPsYgHpt/+hf9y50pnZTdRwgOss89ZA6MmRz60XJ6hqpE2EhUiDdyc4mm
         SjNIae2Wv2ayACyzcvcVrLGgobxrz4PC2VBADYtDWfGLjFvqUYmzks/Ikiaf8NQJutNh
         IuGVfZKBG661V5iZEBTALkKYwV5AerotYPSCnAfoWbXoICxcdo8eM7jXEEm0L6Zb2WmN
         ju7zxd45sXme7R7z6aAMXr3T1jW7WUlUplNq9Hee7E0Y3hItFxcyus+mlZ6rJQDGLA4t
         lW633efM9tzgYt+b5jelDx+4hddk6AZ/MNwwkmYjl3sojJ7rFTeCy6fax4YUMGuoRIPl
         VqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759932113; x=1760536913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxy47Jf+3YxpTMUbbeFHpZ90+HRxyRlrxDfVlXCqO7E=;
        b=IdmavvpQWFhqWsy23qSITfUCnnRCEyfI1zeKUj+ytNkr/u25qUgm4L8VSGc2JxJZrj
         StpUskDJ1N23HHdZ1NwPmWzid/A3eZmHy1riNAXxBPg5U3tYi8u1ZPfA+xX5gkHvC5gY
         FYdzisBbuy/Auje0zQNCw11hMBZ4zfRBMp88XNntvUHBm3J6tDfUoslF6rNZAHfDDaDK
         voofg5/PiEBKm1IICN/yUVj10GV7QIw4JZfhtL2ObyNESRIcyMDdI4JLmyStCgCxNub/
         C+uEq/Lry5yMk8PG2mYNtRA2C+uwfhJWxXRahnp+fQHatv70mHAaYJoVjzqPRfcbUoNe
         Ok9w==
X-Forwarded-Encrypted: i=1; AJvYcCX9+hrLRZlyPYcVqU9BfYJyaWLTGGjx1UHg3LfpwvKSY/Ye07gdCUFhkYwOX1gLUfRYgl0W2El6wrjqZu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyurS0vmBkovRxhHY4HHE/NIyalqpnG2SU1NO/rg/kfWh7kmQl
	IgtY+vYWInp9Wps/i0d274sV9nu5L4z1ZemxPE8gqohlfIGPH9ZOSD5Fm8J3eEq288M=
X-Gm-Gg: ASbGncuIfqCvSwFcTpgoE8fw/MzPHRkFopp7nGTmGR9EN7xzq8WPEuEDC+nqaK9Q7gx
	PQcdRsOJK8jU0VanVWC0ZSZzCie3XRjtnjPSSl45CY/24JAdg+2E5lL5K7mqIauIgybMGldoZej
	9FoEM0mVuUbYhEJsHyu6uIBEHMzoi0sxDpUrFM6yB5hukfB07EzLz62HuwCbmEo50pEGeShEFpn
	714nLiUDO5a7ePntE3tnSFAQrm6G1C8akDdqy4iLHxbeeiF3pKf+Ii9ghJwpVl5R9ASo4kzHSxe
	XS9/+wnzJDkQtQ+xyLEatVRobfrnOLaO3Vpa0v/NVT4IMRZC21sPBAqv3Eip81OPwwVNhdQtQUk
	OFSeZxw22Cxxnk9BOjkLeM/e9yVGs5mounVWLgbe1Is6bohFsKwe2Uky8T6OWzjul
X-Google-Smtp-Source: AGHT+IGKA996Nipx80dBhkWOLU4FiSYMShrWkGYH+e6Uji9z2PsdKXyd60tJ6HeCEMZbp5buzM7XKA==
X-Received: by 2002:a17:907:960b:b0:b3c:193:8218 with SMTP id a640c23a62f3a-b50abaafd4dmr375410366b.34.1759932113040;
        Wed, 08 Oct 2025 07:01:53 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f94asm1662036866b.79.2025.10.08.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:01:52 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:01:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 51/63] objtool/klp: Introduce klp diff subcommand for
 diffing object files
Message-ID: <aOZuzj0vhKPF1bcW@pathway.suse.cz>
References: <cover.1758067942.git.jpoimboe@kernel.org>
 <702078edac02ecf79f869575f06c5b2dba8cd768.1758067943.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702078edac02ecf79f869575f06c5b2dba8cd768.1758067943.git.jpoimboe@kernel.org>

On Wed 2025-09-17 09:03:59, Josh Poimboeuf wrote:
> Add a new klp diff subcommand which performs a binary diff between two
> object files and extracts changed functions into a new object which can
> then be linked into a livepatch module.
> 
> This builds on concepts from the longstanding out-of-tree kpatch [1]
> project which began in 2012 and has been used for many years to generate
> livepatch modules for production kernels.  However, this is a complete
> rewrite which incorporates hard-earned lessons from 12+ years of
> maintaining kpatch.
> 
> --- /dev/null
> +++ b/tools/objtool/klp-diff.c
> +static int read_exports(void)
> +{
> +	const char *symvers = "Module.symvers";
> +	char line[1024], *path = NULL;
> +	unsigned int line_num = 1;
> +	FILE *file;
> +
> +	file = fopen(symvers, "r");
> +	if (!file) {
> +		path = top_level_dir(symvers);
> +		if (!path) {
> +			ERROR("can't open '%s', \"objtool diff\" should be run from the kernel tree", symvers);
> +			return -1;
> +		}
> +
> +		file = fopen(path, "r");
> +		if (!file) {
> +			ERROR_GLIBC("fopen");
> +			return -1;
> +		}
> +	}
> +
> +	while (fgets(line, 1024, file)) {

Nit: It might be more safe to replace 1024 with sizeof(line).
     It might be fixed later in a separate patch.

> +		char *sym, *mod, *type;
> +		struct export *export;
> +
> +		sym = strchr(line, '\t');
> +		if (!sym) {
> +			ERROR("malformed Module.symvers (sym) at line %d", line_num);
> +			return -1;
> +		}
> +

[...]

> +/*
> + * Klp relocations aren't allowed for __jump_table and .static_call_sites if
> + * the referenced symbol lives in a kernel module, because such klp relocs may
> + * be applied after static branch/call init, resulting in code corruption.
> + *
> + * Validate a special section entry to avoid that.  Note that an inert
> + * tracepoint is harmless enough, in that case just skip the entry and print a
> + * warning.  Otherwise, return an error.
> + *
> + * This is only a temporary limitation which will be fixed when livepatch adds
> + * support for submodules: fully self-contained modules which are embedded in
> + * the top-level livepatch module's data and which can be loaded on demand when
> + * their corresponding to-be-patched module gets loaded.  Then klp relocs can
> + * be retired.

I wonder how temporary this is ;-) The comment looks optimistic. I am
just curious. Do you have any plans to implement the support for
the submodules... ?

> + * Return:
> + *   -1: error: validation failed
> + *    1: warning: tracepoint skipped
> + *    0: success
> + */
> +static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym)
> +{
> +	bool static_branch = !strcmp(sym->sec->name, "__jump_table");
> +	bool static_call   = !strcmp(sym->sec->name, ".static_call_sites");
> +	struct symbol *code_sym = NULL;
> +	unsigned long code_offset = 0;
> +	struct reloc *reloc;
> +	int ret = 0;
> +
> +	if (!static_branch && !static_call)
> +		return 0;
> +

Best Regards,
Petr

PS: To make some expectations. I am not doing a deep review.
    I am just looking at the patchset to see how far and mature
    it is. And I just comment what catches my eye.

    My first impression is that it is already in a pretty good state.
    And I do not see any big problem there. Well, some documentation
    would be fine ;-)

    What are your plans, please?

