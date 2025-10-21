Return-Path: <linux-kernel+bounces-863491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E404BF7F89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6D034FE09A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A334E75C;
	Tue, 21 Oct 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j6QYjbUs"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95334D4E2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069075; cv=none; b=LaTU1rSpKujn7yoZK0zFHxACKXEm4QtiNRqytUy4GFP1KtKbbWuskTv4VW/4WiNteYtR86QFkTbY2AvKC2C5+Etrrd7Hn7hQUeBmKLpsA5l2/alSmHiF8bTHF/JZTfptXzLRfRoexi29QNlAwDmINXCAXlKDhi2IaYALNzpByjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069075; c=relaxed/simple;
	bh=uulynMXpJ8L7oZoo/JnalEEKQQI90SdeVbLT2Q7OUmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJvhbljGtcS9gNepHhGpBztwp4/TwJ/hUNplOVdJmLUb+UHylRbjJTVK4F2EeIdMzsZ+DJ7zDtRvJFJU8rKsoxNPJrumgEnlgIzAPGon9Vi9SDvdgBpNCzxtHbPf48XC1wNynh21Vf/DAeOsznRy8M2INwtWywAPk6qOBPtCFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=j6QYjbUs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso8907878a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761069071; x=1761673871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeBYLR+HPAzqZm44zT70Xofjp77IUs91RxgARCWm0c0=;
        b=j6QYjbUsWWY/F8CWhjCzVdJc60A0qtVsOBjfWmSmypcAAxLr12SLg7D7BoBBOBqtoQ
         pCbgi21j4D0bivuS0Ba2Dw4XUKwCm9sWtlMT2auBpeengknFAqjmsOcM7mHPJFM/zR+i
         OM2DpD3/bALZfw4GfxVox0988AyDYtah6YReC2SdIIvSrf0scDESWHGTqQzoAgkUc/JB
         Hq95hidTl01xI1HtAaH6K5bWea0M3y3NLtEZvJiHRPYJMpr14jFahZwY6I5+k9fQg3IE
         u8WGhNyxUOXsFBkbepIRrrqkWN9AaMMyKmWCv4MvuH9dFm+9sxImt8CKZN0sgso9hiSB
         mkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069071; x=1761673871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeBYLR+HPAzqZm44zT70Xofjp77IUs91RxgARCWm0c0=;
        b=chx3GQ4o4rCqPZRa1deVhJthOVLGTWu8rctUGeIycuMuZI94XaONK6MI3uwjO25eSo
         c8pXb6EwLjKGrU2nI3BXy/qf9rxwObM+oXfBs0IOGDTM8Wv/R0zTfK70qL6Ag1LxfMiP
         CLUcnImueexaFoH5kfVZpm9gE6C2ycejl2WsZYv0UMVwn68y4Rb7mESdIuT6QgP0ZNB/
         WJZvMNOmQbMzmzrcJcza/jYY18SBZldA2ei2GePHB9ZxjWjAkCaifBf1Rd0+Kp/DOdHH
         JPLAnf8YSLcgByu6U7NDCpSeErWfphIbUW8CU1K8NFDlDwxs84zK6XQu8Umeyk9GkjHA
         q1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+QEsU0yBQbSlLMImWYawtCAuePQIGjv04Cc2+MXxVq8U7ph2+e7+o7vXI/1fRL5UzTc20WfBkfSGrOn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EFVKbuDShhTYMnJgArhk6pXJOxoRQRZzACQ3EAgtGLbNe58O
	WhzFyDTXQqpaJvXtzlNAeRMaOiolqbzwXcDrgb7gAkV46MDaqxCkeWeG
X-Gm-Gg: ASbGncuAwpYwV/YebX9qziuVduRVnMDpPzUHuyQ0XWiz37u70uP+27CLr/NT7J14Eor
	F9s4qAinoev+3nD1IE274wNQf2UOq4gjU0oMVVJNT6namwY/GJvSewHhmtMBZnaV7Plr6a7yU2y
	Ppe1ve3DsDJ5InyMn0QW2bLBhc9YFEjbLNBjhPndMi3IYOjdMKdsz94VM4y+upesByJ2AtrzFDb
	cD8uP2gy+PT4nZVCAwh4tzshiqepRdNfgJCDPPqd8ycc16WCve9tePDDTw/pIahR3gAAkSHvKQp
	ZB4pEGBrAku9P9zsaxNYya3zye9Bdw4jpOGypJXPQjEf+VYEPFiOfX6RndADwwlRntWfNvFJLgw
	Jxr75PwwPqddITinIN0laUnrW7XPrQi9S8wVH6m2XN3qhcUYfbH+p149JSWM85oc5U6ww6JA7
X-Google-Smtp-Source: AGHT+IHrpAt0rLjva+P5xvD3NT/keHv+NO8Cp9/2lCGhGrs48scqdgskaOvuSk1U3f7LeXkeOhT2xw==
X-Received: by 2002:a05:6402:510f:b0:63c:20a3:70ab with SMTP id 4fb4d7f45d1cf-63c20a37123mr16345212a12.18.1761069071389;
        Tue, 21 Oct 2025 10:51:11 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab52b6sm10017556a12.10.2025.10.21.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:51:10 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Tue, 21 Oct 2025 20:50:03 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net, 
	matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
Message-ID: <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-5-zahari.doychev@linux.com>
 <20251020163221.2c8347ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020163221.2c8347ea@kernel.org>

On Mon, Oct 20, 2025 at 04:32:21PM -0700, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 17:17:37 +0200 Zahari Doychev wrote:
> > The Linux tc actions expect that the action order starts from index
> > one. To accommodate this, add a start-index property to the ynl spec
> > for indexed arrays. This property allows the starting index to be
> > specified, ensuring compatibility with consumers that require a
> > non-zero-based index.
> > 
> > For example if we have "start_index = 1" then we get the following
> > diff.
> > 
> >  		ynl_attr_put_str(nlh, TCA_FLOWER_INDEV, obj->indev);
> >  	array = ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
> >  	for (i = 0; i < obj->_count.act; i++)
> > -		tc_act_attrs_put(nlh, i, &obj->act[i]);
> > +		tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
> >  	ynl_attr_nest_end(nlh, array);
> 
> The first one is just silently skipped by the kernel right?

yes, and then only the second action is being confiugred. The
index defines the action order and the expectation is that they
start from order 1.

> 
> We need to be selective about what API stupidity we try to
> cover up in YNL. Otherwise the specs will be unmanageably complex.
> IMO this one should be a comment in the spec explaining that action
> 0 is ignore and that's it.
> 

I am not sure if this applies for all cases of indexed arrays. For sure
it applies for the tc_act_attrs case but I need to check the rest again.

Do you think it would be fine to start from 1 for all indexed arrays?


