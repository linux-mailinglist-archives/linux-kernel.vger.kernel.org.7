Return-Path: <linux-kernel+bounces-725017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2F9AFF9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1FB3A4D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF7286434;
	Thu, 10 Jul 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWQ4exlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407C1F948;
	Thu, 10 Jul 2025 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128831; cv=none; b=qu4T/o7cyKrPBNrW3WRM1R+J6ze/UtxYbtiDg0s3qDqUqv3wVFRGNgqjneIs4+GEndvv8SlKMcE5ml5n0vv1K5+1XodOzvjBeNA8r2D4rRAq/53rUvokFhUHHj4Y50ged68tr4+r13kPhb+2lcHSv6EDHLWqo55KYzVMHi34g88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128831; c=relaxed/simple;
	bh=FgMAIbywnYWDoP2M5I9ksUW7xiYt3tuJr8sDlOh8U4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8DIk3R0ZssHdzc3I8yxGO6MgcJ2mUvxSlBzHCf6UAY3rxpfgm6+7W4ximOUV0FTQnhBQ7PZIKoOn82jfrJBlXJrQNYn8pKuiCtB3lTA7zA14tLeH6mrY8ubmx7402Lic8lZywyB+4mi/1AoRWQsLoXkFJOo1GUb92a867RyrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWQ4exlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAD3C4CEE3;
	Thu, 10 Jul 2025 06:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752128830;
	bh=FgMAIbywnYWDoP2M5I9ksUW7xiYt3tuJr8sDlOh8U4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bWQ4exlPflTxdNYw//ITcNHXsU/dYIuF0rsLNVB7sy69nagRTaR7mpFgFv1MswnhG
	 KtD/ud1k18hIKoSWGJt0wsVQzG1ofUk3TDRfLgm/sFk/E/slp73TTZm8dHOcPnOGlS
	 267yYIxao+wV51Q+qFmvvWbe/AZsY+Rjzhwx1I/d4p63bGCybJ3CqVWVq1CpKdRtzp
	 HgrROMxn5KtEY0Tt1tuBuU+iXZudTMYbRD7s0J38QFWeIQeOAwbrIukBN4wTOX/QNd
	 a0mVqZT9gqugjtsHaJoytJc1HznZLsQvrH1JF5TRLUmX2eFBLU3OdxQIqWeA/BqL7D
	 9WBS8kQIhqR3A==
Date: Thu, 10 Jul 2025 08:27:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: directly access the always-there
 KdocItem fields
Message-ID: <20250710082706.5f93df25@foz.lan>
In-Reply-To: <20250702223524.231794-11-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-11-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:22 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> They are part of the interface, so use them directly.  This allows the
> removal of the transitional __dict__ hack in KdocItem.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_item.py   |  5 +----
>  scripts/lib/kdoc/kdoc_output.py | 16 +++++++---------
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
> index 51e8669b9a6e..807290678984 100644
> --- a/scripts/lib/kdoc/kdoc_item.py
> +++ b/scripts/lib/kdoc/kdoc_item.py
> @@ -20,10 +20,7 @@ class KdocItem:
>          self.other_stuff = other_stuff
>  
>      def get(self, key, default = None):
> -        ret = self.other_stuff.get(key, default)
> -        if ret == default:
> -            return self.__dict__.get(key, default)
> -        return ret
> +        return self.other_stuff.get(key, default)
>  
>      def __getitem__(self, key):
>          return self.get(key)
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index 8a31b637ffd2..ea8914537ba0 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -124,9 +124,7 @@ class OutputFormat:
>          Output warnings for identifiers that will be displayed.
>          """
>  
> -        warnings = args.get('warnings', [])
> -
> -        for log_msg in warnings:
> +        for log_msg in args.warnings:
>              self.config.warning(log_msg)
>  
>      def check_doc(self, name, args):
> @@ -184,7 +182,7 @@ class OutputFormat:
>  
>          self.data = ""
>  
> -        dtype = args.get('type', "")
> +        dtype = args.type
>  
>          if dtype == "doc":
>              self.out_doc(fname, name, args)
> @@ -373,7 +371,7 @@ class RestFormat(OutputFormat):
>                  signature = args['functiontype'] + " "
>              signature += name + " ("
>  
> -        ln = args.get('declaration_start_line', 0)
> +        ln = args.declaration_start_line
>          count = 0
>          for parameter in args.parameterlist:
>              if count != 0:
> @@ -445,7 +443,7 @@ class RestFormat(OutputFormat):
>      def out_enum(self, fname, name, args):
>  
>          oldprefix = self.lineprefix
> -        ln = args.get('declaration_start_line', 0)
> +        ln = args.declaration_start_line
>  
>          self.data += f"\n\n.. c:enum:: {name}\n\n"
>  
> @@ -474,7 +472,7 @@ class RestFormat(OutputFormat):
>      def out_typedef(self, fname, name, args):
>  
>          oldprefix = self.lineprefix
> -        ln = args.get('declaration_start_line', 0)
> +        ln = args.declaration_start_line
>  
>          self.data += f"\n\n.. c:type:: {name}\n\n"
>  
> @@ -492,8 +490,8 @@ class RestFormat(OutputFormat):
>  
>          purpose = args.get('purpose', "")
>          declaration = args.get('definition', "")
> -        dtype = args.get('type', "struct")
> -        ln = args.get('declaration_start_line', 0)
> +        dtype = args.type
> +        ln = args.declaration_start_line
>  
>          self.data += f"\n\n.. c:{dtype}:: {name}\n\n"
>  



Thanks,
Mauro

