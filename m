Return-Path: <linux-kernel+bounces-870365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EBFC0A868
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C473A6A96
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0E2DECDE;
	Sun, 26 Oct 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi1KbTTq"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DA243946
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761483448; cv=none; b=IyPzZHbrTHnLUSUxY2shO6JGKrJUUkf1kge3NVtj0LB7+OTa1HIjp4MlZl5mC7b15iNCXalH1G16ZpjF8FDpOIVfxmnQCpVfyIKPNbCbTo2FI9czb5CxbU9q+qPgIuTj6DUOetAIqPdr8maf1l32T3riYn9VLLzZ9qLCNJtdwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761483448; c=relaxed/simple;
	bh=rCGw4ZbsZQCpqBLJPg/c9+/fXOA/cXyXFOwoHEEcBhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6ai0lAvWdgVP6tRoTbJftzaaLaf125Cbl3C992eOhFdcucYJZB2uKMWIAzemq924J+kBbH3ycaBWvvxxec72MkYuDWMUzzbp6wUBZOS3zM/5Dfc7hNcLYc+6lNWh7Pbx49OejrAGkGTOcd8qGTY1ZuqQKcla/S+gtZaIXxLwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi1KbTTq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3b27b50090so656040366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761483445; x=1762088245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETXrEZX5fQ8Oi3Y5mw2OqmhS1VtxyB2GFpSLLiFAkrE=;
        b=Mi1KbTTqziQFPAvBKPvSJMexoWUA3AYoYm2lymk5rhdVysogyp/NVZsGt+I3tYluho
         xC6NZzKRpdYi14wvMh5zPKaRKve6kRBeQMUJTmAyzHwhBbDchw1dw7uv38gPEFP8kMlP
         t+Ga+0v99K4Po/WlAP2fSEhk2F2UjzHQBEDp+3exA1qdeE6tPOo/RjwRoKKk76DpT5pz
         0NgKHDru0M1OXS5Uc+XXzjxyYbIt0lGNh6K4nG70XcZD87BUX2EA60H9LYonHWwTYAE1
         lgzx7mZyPFzo1MFxpPmrMiK1ui3plDQptMIAUZIfGBMgelN2iC+njNopN7HXKXupaES+
         nJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761483445; x=1762088245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETXrEZX5fQ8Oi3Y5mw2OqmhS1VtxyB2GFpSLLiFAkrE=;
        b=S/xLdHlIriU4l4BmU6QHIk5nWf3OSQu3wXFQHFbahaFfI2K7K0UV20+HxamK1S67dC
         mNWIKrBxb/5bPrzndq3/RqxHIlL3bpCkAqabLc2jxxb5dTshgSfgFURamVv67ArzcFrx
         8YDirjxOUpukLBQOLWX/ELuil1Qx0eH6JS8z9qOKziYhcR9blp0jkhyDcJmf1UWOXlLG
         IaY8qwMvCu6J3PwzmDSkgjp+fCAEmfewL8HcJ3hS9iG6UmY4BJm4qnv5ahyPPKfKkwLZ
         GdxMLyupNGLRnCp4s+TMS2DhBF83vZjj3EyKBQtU0zP1uHh6nu8bxFTCHBs7Cp7le5iL
         KfgA==
X-Forwarded-Encrypted: i=1; AJvYcCV1q1mkHbzkhoUc4FLfHYjmLLhSC4pHdpwR5KB7dzdb9efsyTIKwNSB25GH87D8IscEQXx0Y4qdtypwyxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bOMhA1F9yL1R4cC+pxqldbgKBZcK224Z+ey2PuGbR3892BNQ
	MO9xo4R6mCzDGk1mPHuvCclyjOw2tUGp/8m6gqfXLbtlkSA0Ot08+pz3
X-Gm-Gg: ASbGncuMcKpFlS1xtqakIAE0hHRVL8aw/KPxC+KQSFQcRfm21ya1r+JegCLuJcbZMpB
	eaRh3APnQU2g6zrJb7qivtRR1hRuzXZNT8DQFQXkVSdse4jF5LyRMdJKLVIuMKr5dEPxeXJyiGV
	j12tOeFQ5SljnXBDlTIzlx/xhFxVwPTukOcnnIhY7atACmV9oX9L4QRUW+SwmRIKjDskULgISlS
	ZUDRA2RxdUzXN3OFJDfHgJ6VGgG79oqXtr4tbyXdkk3pkUdQxjy7hd32XJWCnBcoRBGqWb19Wo1
	lvNh1Tl/xjZEIN/8SZJQjOVCkoTDoo0UiEvC66yt3wCvgEfJq5049K5ciYT6vEY9kogncJHbAhg
	doGfOa6CQq8iOj9ZCDhPiiiWlCfRa8HuGRh1MUCdBqVk4VxlK+9/u5o1XNv9Y18hbBiS0HN/kR7
	Ag37qkcmcxHR3pJeDxSFa4LQ/uZMlAR5ARTXPUCKKKBXbv
X-Google-Smtp-Source: AGHT+IGVz/VPRAxaoxwbFjYCLhD1ar+3bJt34o/sZ1Velhqhsmkm8EcDtkmYcSESmb5WVANXKCHAUQ==
X-Received: by 2002:a17:907:3d87:b0:b3f:b7ca:26c5 with SMTP id a640c23a62f3a-b647570a3d9mr3880397366b.59.1761483444461;
        Sun, 26 Oct 2025 05:57:24 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8541fb2esm453815766b.59.2025.10.26.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 05:57:22 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 51C38BE2EE7; Sun, 26 Oct 2025 13:56:58 +0100 (CET)
Date: Sun, 26 Oct 2025 13:56:58 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Andreas Radke <andreas.radke@mailbox.org>
Cc: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Zhixu Liu <zhixu.liu@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Please backport commit 00d95fcc4dee ("docs: kdoc: handle the
 obsolescensce of docutils.ErrorString()") to v6.17.y
Message-ID: <aP4amn4YQDnzBBCU@eldamar.lan>
References: <aPUCTJx5uepKVuM9@eldamar.lan>
 <DDS2XJZB0ECJ.N4LNABSIJHAJ@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDS2XJZB0ECJ.N4LNABSIJHAJ@mailbox.org>

Hi,

On Sun, Oct 26, 2025 at 08:36:00AM +0100, Andreas Radke wrote:
> For kernel 6.12 there's just one more place required to add the fix:
> 
> --- a/Documentation/sphinx/kernel_abi.py        2025-10-23 16:20:48.000000000 +0200
> +++ b/Documentation/sphinx/kernel_abi.py.new    2025-10-26 08:08:33.168985951 +0100
> @@ -42,9 +42,11 @@
>  from docutils import nodes, statemachine
>  from docutils.statemachine import ViewList
>  from docutils.parsers.rst import directives, Directive
> -from docutils.utils.error_reporting import ErrorString
>  from sphinx.util.docutils import switch_source_input
> 
> +def ErrorString(exc):  # Shamelessly stolen from docutils
> +    return f'{exc.__class__.__name}: {exc}'
> +
>  __version__  = '1.0'
> 
>  def setup(app):

Yes this is why I asked Jonathan, how to handle backports to older
series, if it is wanted to pick specifically as well faccc0ec64e1
("docs: sphinx/kernel_abi: adjust coding style") or a partial backport
of it, or do a 6.12.y backport of 00d95fcc4dee with additional
changes (like you pointed out).

I'm just not sure what is preferred here. 

Regards,
Salvatore

