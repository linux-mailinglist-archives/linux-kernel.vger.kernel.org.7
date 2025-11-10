Return-Path: <linux-kernel+bounces-892257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6885C44B80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37493A6BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79D1448E3;
	Mon, 10 Nov 2025 01:21:47 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E218E1F;
	Mon, 10 Nov 2025 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762737706; cv=none; b=Y9KIqGN7mQ+vdpZEHKc3j0WbzjLYTFMe3OUDn4ojvbkkfOtK8imrQ3qPhrQl6SP03QeWyxJVWtRPz/kpfT7p1U99x0NoSz5Y5ZbbdVMpifOj6BDCibKELB1u34LQOVHa2AHSWcgbL5B2iDoqxLgHAM2wHLfMilDUWKkAEuYJWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762737706; c=relaxed/simple;
	bh=l/BGVjZuaI3XqqAaoC3wWphJ+ga3SxOjxWNrrasNT2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPCIAI0Glvp4LmWzIhY0fXyO9xznAjkDdbosKFu9SCWuO/fQDv61P+poC9AgFrNXYL0Lb60uKf1/Jg2rbmpI1xurmyGb0SiwfzFlHgA5quBHMo1xF2TviE+wRwPSrPLLB65txb/qgTv7maTFdRUgyMaY7D2PzLK1oPelDTmwuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADXuXrZPRFpoiaWBQ--.49136S2;
	Mon, 10 Nov 2025 09:20:26 +0800 (CST)
Received: from [10.12.170.119] (unknown [10.12.170.119])
	by gateway (Coremail) with SMTP id _____wBHIUrOPRFpI6ZxAA--.54751S2;
	Mon, 10 Nov 2025 09:20:15 +0800 (CST)
Message-ID: <e987fda3-2c76-40a7-babd-887242b99cb1@hust.edu.cn>
Date: Mon, 10 Nov 2025 09:20:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: doc-guide: parse-headers.rst update its
 documentation
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Yanteng Si <si.yanteng@linux.dev>,
 linux-kernel@vger.kernel.org
References: <2ae06f370724bfd8210892ef3062cb349ed518f2.1762512037.git.mchehab+huawei@kernel.org>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <2ae06f370724bfd8210892ef3062cb349ed518f2.1762512037.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrADXuXrZPRFpoiaWBQ--.49136S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoW3trWrAr1kZFy7Zw4fGr48JFb_yoW8JFyDWo
	Z3Kr4Sy3y7Ar1UXw4kCryvyFWxuFyxCrn7JrW7Kr98Was3WrWrKw4rZw4vvrWfXw15GFnx
	W3s7Z3y3WFZxtF15n29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOy7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xv
	wVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxV
	WUAVWUtwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY
	07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI
	0_Gr1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4U
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUvYsjDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 11/7/25 6:40 PM, Mauro Carvalho Chehab wrote:
> Besides converting from Perl to Python, parse-headers has gained
> some new functionality and was moved to tools/docs.
>
> Update its documentation accordingly.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-doc/9391a0f0-7c92-42aa-8190-28255b22e131@infradead.org/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/doc-guide/parse-headers.rst     | 195 +++++++++---------
>   .../it_IT/doc-guide/parse-headers.rst         |   8 +-
>   .../zh_CN/doc-guide/parse-headers.rst         |   8 +-
>   3 files changed, 103 insertions(+), 108 deletions(-)
>
> diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
> index 204b025f1349..954f3285ddf6 100644
> --- a/Documentation/doc-guide/parse-headers.rst
> +++ b/Documentation/doc-guide/parse-headers.rst
> @@ -8,170 +8,165 @@ between the code and the documentation. Adding cross-references for
>   userspace API files has an additional vantage: Sphinx will generate warnings
>   if a symbol is not found at the documentation. That helps to keep the
>   uAPI documentation in sync with the Kernel changes.
> -The :ref:`parse_headers.pl <parse_headers>` provide a way to generate such
> +The :ref:`parse_headers.py <parse_headers>` provides a way to generate such
>   cross-references. It has to be called via Makefile, while building the
>   documentation. Please see ``Documentation/userspace-api/media/Makefile`` for an example
>   about how to use it inside the Kernel tree.
>   
>   .. _parse_headers:
>   
> -parse_headers.pl
> -^^^^^^^^^^^^^^^^
> +tools/docs/parse_headers.py
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
>   NAME
>   ****
>   
> -
> -parse_headers.pl - parse a C file, in order to identify functions, structs,
> +parse_headers.py - parse a C file, in order to identify functions, structs,
>   enums and defines and create cross-references to a Sphinx book.
>   
> +USAGE
> +*****
> +
> +parse-headers.py [-h] [-d] [-t] ``FILE_IN`` ``FILE_OUT`` ``FILE_RULES``
>   
>   SYNOPSIS
>   ********
>   
> +Converts a C header or source file ``FILE_IN`` into a ReStructured Text
> +included via ..parsed-literal block with cross-references for the
> +documentation files that describe the API. It accepts an optional
> +``FILE_RULES`` file to describe what elements will be either ignored or
> +be pointed to a non-default reference type/name.
>   
> -\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
> +The output is written at ``FILE_OUT``.
>   
> -Where <options> can be: --debug, --help or --usage.
> +It is capable of identifying ``define``, ``struct``, ``typedef``, ``enum``
> +and enum ``symbol``, creating cross-references for all of them.
>   
> +It is also capable of distinguishing ``#define`` used for specifying
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
>   OPTIONS
>   *******
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
>   DESCRIPTION
>   ***********
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
> +It accepts an optional ``FILE_RULES`` which describes what elements will be
> +either ignored or be pointed to a non-default reference, and optionally
> +defines the C namespace to be used.
>   
> -The output is written at the (OUT_FILE).
> +It is meant to allow having more comprehensive documentation, where
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
> +    Replaces *old_symbol* with a *new_reference*.
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
> +        for defines of the form ``_IO*``, e.g., ioctl definitions
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
>   EXAMPLES
>   ********
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
> +- Use C namespace ``MC`` for all symbols at ``FILE_IN``::
>   
> +    namespace MC
>   
>   BUGS
>   ****
> @@ -184,7 +179,7 @@ COPYRIGHT
>   *********
>   
>   
> -Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
> +Copyright (c) 2016, 2025 by Mauro Carvalho Chehab <mchehab+huawei@kernel.org>.
>   
>   License GPLv2: GNU GPL version 2 <https://gnu.org/licenses/gpl.html>.
>   
> diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
> index 026a23e49767..b0caa40fe1e9 100644
> --- a/Documentation/translations/it_IT/doc-guide/parse-headers.rst
> +++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
> @@ -13,28 +13,28 @@ dello spazio utente ha ulteriori vantaggi: Sphinx genererà dei messaggi
>   d'avviso se un simbolo non viene trovato nella documentazione. Questo permette
>   di mantenere allineate la documentazione della uAPI (API spazio utente)
>   con le modifiche del kernel.
> -Il programma :ref:`parse_headers.pl <it_parse_headers>` genera questi riferimenti.
> +Il programma :ref:`parse_headers.py <it_parse_headers>` genera questi riferimenti.
>   Esso dev'essere invocato attraverso un Makefile, mentre si genera la
>   documentazione. Per avere un esempio su come utilizzarlo all'interno del kernel
>   consultate ``Documentation/userspace-api/media/Makefile``.
>   
>   .. _it_parse_headers:
>   
> -parse_headers.pl
> +parse_headers.py
>   ^^^^^^^^^^^^^^^^
>   
>   NOME
>   ****
>   
>   
> -parse_headers.pl - analizza i file C al fine di identificare funzioni,
> +parse_headers.py - analizza i file C al fine di identificare funzioni,
>   strutture, enumerati e definizioni, e creare riferimenti per Sphinx
>   
>   SINTASSI
>   ********
>   
>   
> -\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
> +\ **parse_headers.py**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
>   
>   Dove <options> può essere: --debug, --usage o --help.
>   
> diff --git a/Documentation/translations/zh_CN/doc-guide/parse-headers.rst b/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
> index a08819e904ed..65d9dc5143ff 100644
> --- a/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/parse-headers.rst

The changes to zh_CN translation are fine to me.

Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

> @@ -13,20 +13,20 @@
>   有时，为了描述用户空间API并在代码和文档之间生成交叉引用，需要包含头文件和示例
>   C代码。为用户空间API文件添加交叉引用还有一个好处：如果在文档中找不到相应符号，
>   Sphinx将生成警告。这有助于保持用户空间API文档与内核更改同步。
> -:ref:`parse_headers.pl <parse_headers_zh>` 提供了生成此类交叉引用的一种方法。
> +:ref:`parse_headers.py <parse_headers_zh>` 提供了生成此类交叉引用的一种方法。
>   在构建文档时，必须通过Makefile调用它。有关如何在内核树中使用它的示例，请参阅
>   ``Documentation/userspace-api/media/Makefile`` 。
>   
>   .. _parse_headers_zh:
>   
> -parse_headers.pl
> +parse_headers.py
>   ----------------
>   
>   脚本名称
>   ~~~~~~~~
>   
>   
> -parse_headers.pl——解析一个C文件，识别函数、结构体、枚举、定义并对Sphinx文档
> +parse_headers.py——解析一个C文件，识别函数、结构体、枚举、定义并对Sphinx文档
>   创建交叉引用。
>   
>   
> @@ -34,7 +34,7 @@ parse_headers.pl——解析一个C文件，识别函数、结构体、枚举、
>   ~~~~~~~~
>   
>   
> -\ **parse_headers.pl**\  [<选项>] <C文件> <输出文件> [<例外文件>]
> +\ **parse_headers.py**\  [<选项>] <C文件> <输出文件> [<例外文件>]
>   
>   <选项> 可以是： --debug, --help 或 --usage 。
>   


