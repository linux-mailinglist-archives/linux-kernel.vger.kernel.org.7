Return-Path: <linux-kernel+bounces-861463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A8BF2C92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A35434E0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9A2BF001;
	Mon, 20 Oct 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RuT3CWZL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670A13C3CD;
	Mon, 20 Oct 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982329; cv=none; b=WhbMk70bwCTfSsZnRHol2Q0ZpfB8uNn/iTjNYARA6Q5u1Qcw4pV0ZU5UDg+JoUVTX5k92IqtO+CES4O3ZrcTjX5uvzLU2RManSKkSnRbbOuhR6pdRYDj4dQH2uxmFSeNjzmmvHdWcerqZ5vycAeVan8Gdu6u8gM9EYdbKIAUWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982329; c=relaxed/simple;
	bh=bYQR/5vQvPUGwCzKoZyUJri1/1X3ZG5l05tDKKRmArU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8T5M2r5k7Q27/EuLUBc4SUsZVOa6egLm0jJZoJGDvPuV5jWjOQIL3E+yLhVQwXK+9g82v9c5grWLd/TjMYW2CKbfKSFYHr3sQkG+y/kvMPw8QSnR4hXbu1CMoZTJL/THeL620YjJ6Qr8hYG9yZxqHoOmFSVFGqZW0a/GRj7g3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RuT3CWZL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PUPDIOI1uFe0vvf8Eo3u6qbVWOwroV4+LAoO1wQWl/s=; b=RuT3CWZLySj0gH1ilsKrXFtlXw
	NVFr4X3gQfpbXVYQGilJIhcxcKu7kGjRacK+aysa2hPteTkmysW04TGkXD9GBAP+h6MV+YiQtL+rg
	ZqyOku1MkTGPAeAW4QIthR3Z1xI9Ll8fg3XhEfxcj5EC3g3OHXzY/WWZH3ZY7t/XNfl7As4533IvS
	SuP9YbpUTA4S5EIRx3zCmXaJ4n77dPblGVgAiFWoxdmQU08yjrPMwdk3aBQPTLDKwFZzqa5c9ER4U
	Pca1WsbhmAwjqNzz9Iml0sBU42k151QG9HPogqBK6YyxkYt1B0yX2qsXQ+wR832gOyMbo+BZWzQBo
	bL1XZo8w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtwj-0000000EXDc-0ZkG;
	Mon, 20 Oct 2025 17:45:25 +0000
Message-ID: <a05d3415-9e52-4d0c-92d7-8eda6e37d9c5@infradead.org>
Date: Mon, 20 Oct 2025 10:45:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: doc-guide: parse-headers.rst update its
 documentation
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Yanteng Si <si.yanteng@linux.dev>,
 linux-kernel@vger.kernel.org
References: <309cb1b309a484e02c1951390fc1d169c2dc50dd.1760962285.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <309cb1b309a484e02c1951390fc1d169c2dc50dd.1760962285.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/25 5:11 AM, Mauro Carvalho Chehab wrote:
> Besides converting from Perl to Python, parse-headers has gained
> some new functionality and was moved to tools/docs.
> 
> Update its documentation accordingly.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-doc/9391a0f0-7c92-42aa-8190-28255b22e131@infradead.org/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/doc-guide/parse-headers.rst     | 195 +++++++++---------
>  .../it_IT/doc-guide/parse-headers.rst         |   8 +-
>  .../zh_CN/doc-guide/parse-headers.rst         |   8 +-
>  3 files changed, 103 insertions(+), 108 deletions(-)
> 

> diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
> index 204b025f1349..c1ad0fcfd34d 100644
> --- a/Documentation/doc-guide/parse-headers.rst
> +++ b/Documentation/doc-guide/parse-headers.rst
> @@ -8,170 +8,165 @@ between the code and the documentation. Adding cross-references for
>  userspace API files has an additional vantage: Sphinx will generate warnings
>  if a symbol is not found at the documentation. That helps to keep the
>  uAPI documentation in sync with the Kernel changes.
> -The :ref:`parse_headers.pl <parse_headers>` provide a way to generate such
> +The :ref:`parse_headers.py <parse_headers>` provide a way to generate such

                                               provides

>  cross-references. It has to be called via Makefile, while building the
>  documentation. Please see ``Documentation/userspace-api/media/Makefile`` for an example
>  about how to use it inside the Kernel tree.
>  
>  .. _parse_headers:
>  
> -parse_headers.pl
> -^^^^^^^^^^^^^^^^
> +tools/docs/parse_headers.py
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  NAME
>  ****
>  
> -
> -parse_headers.pl - parse a C file, in order to identify functions, structs,
> +parse_headers.py - parse a C file, in order to identify functions, structs,
>  enums and defines and create cross-references to a Sphinx book.
>  
> +USAGE
> +*****
> +
> +parse-headers.py [-h] [-d] [-t] ``FILE_IN`` ``FILE_OUT`` ``FILE_RULES``
>  
>  SYNOPSIS
>  ********
>  
> +Converts a C header or source file ``FILE_IN``, into a ReStructured Text

                                       no comma ^^^

> +included via ..parsed-literal block with cross-references for the
> +documentation files that describe the API. It accepts an optional
> +``FILE_RULES`` file to describes what elements will be either ignored or

                          describe

> +be pointed to a non-default reference type/name.
>  
> -\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
> +The output is written at ``FILE_OUT``.
>  
> -Where <options> can be: --debug, --help or --usage.
> +It is capable of identifying ``define``, ``struct``, ``typedef``, ``enum``
> +and enum ``symbol``, creating cross-references for all of them.
>  
> +It is also capable of distinguish ``#define`` used for specifying

                         distinguishing

> +Linux-specific macros used to define ``ioctl``.
> +
> +The optional ``FILE_RULES`` contains a set of rules like::
> +
> +    ignore ioctl VIDIOC_ENUM_FMT
> +    replace ioctl VIDIOC_DQBUF vidioc_qbuf
> +    replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
> +
> +POSITIONAL ARGUMENTS
> +********************
> +
> +  ``FILE_IN``
> +      Input C file
> +
> +  ``FILE_OUT``
> +      Output RST file
> +
> +  ``FILE_RULES``
> +      Exceptions file (optional)
>  
>  OPTIONS
>  *******
>  
> -
> -
> -\ **--debug**\
> -
> - Put the script in verbose mode, useful for debugging.
> -
> -
> -
> -\ **--usage**\
> -
> - Prints a brief help message and exits.
> -
> -
> -
> -\ **--help**\
> -
> - Prints a more detailed help message and exits.
> +  ``-h``, ``--help``
> +      show a help message and exit
> +  ``-d``, ``--debug``
> +      Increase debug level. Can be used multiple times
> +  ``-t``, ``--toc``
> +      instead of a literal block, outputs a TOC table at the RST file
>  
>  
>  DESCRIPTION
>  ***********
>  
> +Creates an enriched version of a Kernel header file with cross-links
> +to each C data structure type, from ``FILE_IN``, formatting it with
> +reStructuredText notation, either as-is or as a table of contents.
>  
> -Convert a C header or source file (C_FILE), into a reStructuredText
> -included via ..parsed-literal block with cross-references for the
> -documentation files that describe the API. It accepts an optional
> -EXCEPTIONS_FILE with describes what elements will be either ignored or
> -be pointed to a non-default reference.
> +It accepts an optional ``FILE_RULES`` with describes what elements will be

                                         which

> +either ignored or be pointed to a non-default reference, and optionally
> +defines the C namespace to be used.
>  
> -The output is written at the (OUT_FILE).
> +It is meant to allow having a more comprehensive documentation, where

                        having more

> +uAPI headers will create cross-reference links to the code.
>  
> -It is capable of identifying defines, functions, structs, typedefs,
> -enums and enum symbols and create cross-references for all of them.
> -It is also capable of distinguish #define used for specifying a Linux
> -ioctl.
> +The output is written at the (``FILE_OUT``).
>  
> -The EXCEPTIONS_FILE contain two types of statements: \ **ignore**\  or \ **replace**\ .
> +The ``FILE_RULES`` may contain contain three types of statements:
> +**ignore**, **replace** and **namespace**.
>  
> -The syntax for the ignore tag is:
> +By default, it create rules for all symbols and defines, but it also
> +allows parsing an exception file. Such file contains a set of rules
> +using the syntax below:
>  
> +1. Ignore rules:
>  
> -ignore \ **type**\  \ **name**\
> +    ignore *type* *symbol*
>  
> -The \ **ignore**\  means that it won't generate cross references for a
> -\ **name**\  symbol of type \ **type**\ .
> +Removes the symbol from reference generation.
>  
> -The syntax for the replace tag is:
> +2. Replace rules:
>  
> +    replace *type* *old_symbol* *new_reference*
>  
> -replace \ **type**\  \ **name**\  \ **new_value**\
> +    Replaces how *old_symbol* with a *new_reference*.

Drop "how".

> +    The *new_reference* can be:
>  
> -The \ **replace**\  means that it will generate cross references for a
> -\ **name**\  symbol of type \ **type**\ , but, instead of using the default
> -replacement rule, it will use \ **new_value**\ .
> +    - A simple symbol name;
> +    - A full Sphinx reference.
>  
> -For both statements, \ **type**\  can be either one of the following:
> +3. Namespace rules
>  
> +    namespace *namespace*
>  
> -\ **ioctl**\
> +    Sets C *namespace* to be used during cross-reference generation. Can
> +    be overridden by replace rules.
>  
> - The ignore or replace statement will apply to ioctl definitions like:
> +On ignore and replace rules, *type* can be:
>  
> - #define	VIDIOC_DBG_S_REGISTER 	 _IOW('V', 79, struct v4l2_dbg_register)
> +    - ioctl:
> +        for defines that end with ``_IO*``, e.g. ioctl definitions

"end with"? How about
           for defines of the form ``_IO*``, e.g., ioctl definitions

>  
> +    - define:
> +        for other defines
>  
> +    - symbol:
> +        for symbols defined within enums;
>  
> -\ **define**\
> +    - typedef:
> +        for typedefs;
>  
> - The ignore or replace statement will apply to any other #define found
> - at C_FILE.
> -
> -
> -
> -\ **typedef**\
> -
> - The ignore or replace statement will apply to typedef statements at C_FILE.
> -
> -
> -
> -\ **struct**\
> -
> - The ignore or replace statement will apply to the name of struct statements
> - at C_FILE.
> -
> -
> -
> -\ **enum**\
> -
> - The ignore or replace statement will apply to the name of enum statements
> - at C_FILE.
> -
> -
> -
> -\ **symbol**\
> -
> - The ignore or replace statement will apply to the name of enum value
> - at C_FILE.
> -
> - For replace statements, \ **new_value**\  will automatically use :c:type:
> - references for \ **typedef**\ , \ **enum**\  and \ **struct**\  types. It will use :ref:
> - for \ **ioctl**\ , \ **define**\  and \ **symbol**\  types. The type of reference can
> - also be explicitly defined at the replace statement.
> +    - enum:
> +        for the name of a non-anonymous enum;
>  
> +    - struct:
> +        for structs.
>  
>  
>  EXAMPLES
>  ********
>  
> +- Ignore a define ``_VIDEODEV2_H`` at ``FILE_IN``::
>  
> -ignore define _VIDEODEV2_H
> +    ignore define _VIDEODEV2_H
>  
> +- On an data structure like this enum::
>  
> -Ignore a #define _VIDEODEV2_H at the C_FILE.
> +    enum foo { BAR1, BAR2, PRIVATE };
>  
> -ignore symbol PRIVATE
> +  It won't generate cross-references for ``PRIVATE``::
>  
> +    ignore symbol PRIVATE
>  
> -On a struct like:
> +  At the same struct, instead of creating one cross reference per symbol,
> +  make them all point to the ``enum foo`` C type::
>  
> -enum foo { BAR1, BAR2, PRIVATE };
> +    replace symbol BAR1 :c:type:\`foo\`
> +    replace symbol BAR2 :c:type:\`foo\`
>  
> -It won't generate cross-references for \ **PRIVATE**\ .
>  
> -replace symbol BAR1 :c:type:\`foo\`
> -replace symbol BAR2 :c:type:\`foo\`
> -
> -
> -On a struct like:
> -
> -enum foo { BAR1, BAR2, PRIVATE };
> -
> -It will make the BAR1 and BAR2 enum symbols to cross reference the foo
> -symbol at the C domain.
> +- Use C namepace ``MC`` for all symbols at ``FILE_IN``::

           namespace

>  
> +    namespace MC
>  
>  BUGS
>  ****
> @@ -184,7 +179,7 @@ COPYRIGHT
>  *********
>  
>  
> -Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
> +Copyright (c) 2016, 2025 by Mauro Carvalho Chehab <mchehab+huawei@kernel.org>.
>  
>  License GPLv2: GNU GPL version 2 <https://gnu.org/licenses/gpl.html>.
>  

Thanks for the updated info.
-- 
~Randy


