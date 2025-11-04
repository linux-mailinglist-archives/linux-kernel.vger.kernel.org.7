Return-Path: <linux-kernel+bounces-884554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B10BCC306F1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D6554E3E34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130F31280A;
	Tue,  4 Nov 2025 10:10:55 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212F305942
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251055; cv=none; b=qkFC2ENbydRmhdIPXMMenrVrJjO8sgx/z6CywnE2xSC3Chas9CycCwNU5PzDUogSG1yw0YlM88T1xNyud1cTR2rYeXISDxJt+jb6W8Ba61atSOd+ThRN/CJKO0Y/3vot8yzhCcUHWFxlDS0uymAL4SdhJZsxq+E4/WFunrb60DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251055; c=relaxed/simple;
	bh=vphX3sqVulabTSJQXzMXPyWDMPXt6ICj4L0/fNeVBd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNXp4R23e419K4KmVfscQcY1WidIEls7VnnmkrvkGEeW0B4efPBJ369yxtUYhu1JEO2uBxs9T+dIGI+AIAZA/JPqQ5lIxVWUz82pf9fME5Ow6HxmcXqtyy+qMGG3sGbtdCkdAwGSDN9+mB6EAACbJfgFuPIQnKZwnOAOvYkVjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so3429237a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251052; x=1762855852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQRyYoU8dE0NiQKdt3NAGh+nYpn/CK2YjzQBoDa64Ww=;
        b=LrEtTCZuGQ8WZI02aD+NpSnG1FLlSwM178ETunS9k5u+BEhp0BfVQ4AjSOTlgbcc9a
         w2oHdYNM3zZ27+esTqwl2sjeYfxv+eNoeCfozopkIXn9wHocP7hH0z573MwtefRCOl1a
         uos4uD1tUEPXzwEkQ/AIabNCTy1naHjs9HQyqynfG0cJkhMu6GdUetTFQ0pmFcTFBGHX
         X6fvLZYxqmD8wT9OfRgMm71Iz/LvCSJ1xpmjlnzk1WzGe0wEF1EOnu8JV2kEZDVAQy8t
         HecilX2TGYTy5EOyvdkahCtw6+XvzgS4h/ng0zFhnxH8JUtacjJrUO9xsDz9IvlQeOJs
         VHfA==
X-Forwarded-Encrypted: i=1; AJvYcCWcOb86yzWEHf+4twDvslWrSXg6f37hlxSSMNnBPLF9AVGCDATHTuNeVZkd5NwHAAUGSL5mSd2yuHw3mB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/7x3rKOJWTfwi+ggXXnoolmE6oirvn9qfU9XRPcVc9lVPGO2
	OtdqOKjby7paUYh23XzWQ7hagRC4z8kt364mIYy7mEWrdD29xoZmZKYf
X-Gm-Gg: ASbGncujcubD9gdQnpjCsvl/XiYViyEkwaOOluw/bEg0J/cR2l978A0Bt/iJlwQzK91
	PMKPigIPXf0Y7t+XWWNN0J4lxqNQKMmJ8ah7g9nnL9xtHqjI+d1i2OFisGUUsS7JXBO47hJ0q1y
	eqy8qwC9VRRTo8lZFiDamVU55TDhF3MqEF3KZYBYZ42Tsbgn+LwKJVtEsyE5G+zm1hf8HwnRRXh
	bMLg5WQ8WPPDpzXk0XxWhNAIfmEwNj0Ifr0h0y94IlL+r+8iSc5y4+QV77vBneu53AbBq4uMHHs
	XnNTR5rZH2lNnUTxEMicekugFQUtgq6djxAty3PIe/j5ZfT/dcLCJLQt9nfLQ/x9s0/kehJbeiy
	hO0TcRNloXrxOsemI8mORoHCy9yGanopgpio7vzf1Cadk7Qna2QnXg/eDcKMFmlggMA==
X-Google-Smtp-Source: AGHT+IE5n+W7kuHxaU2GI3gUJHfZsywJ1XbuGrnd2U3e2o1L03zP/wQqsIBEVZktbbdno7CzDzzZ2Q==
X-Received: by 2002:a05:6402:460d:20b0:640:af04:d71d with SMTP id 4fb4d7f45d1cf-640af04d8a7mr6788744a12.22.1762251052101;
        Tue, 04 Nov 2025 02:10:52 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b50sm1688166a12.25.2025.11.04.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:10:50 -0800 (PST)
Date: Tue, 4 Nov 2025 02:10:48 -0800
From: Breno Leitao <leitao@debian.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: a.hindborg@kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] configfs: Constify ct_item_ops in struct
 config_item_type
Message-ID: <3non5zhg364r3hajwl2td5xrajjy24drb5ehd3jdvuyjxhhff3@eyl5m45wlckz>
References: <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
 <f43cb57418a7f59e883be8eedc7d6abe802a2094.1761390472.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43cb57418a7f59e883be8eedc7d6abe802a2094.1761390472.git.christophe.jaillet@wanadoo.fr>

On Sat, Oct 25, 2025 at 01:15:38PM +0200, Christophe JAILLET wrote:
> Make 'ct_item_ops' const in struct config_item_type.
> This allows constification of many structures which hold some function
> pointers.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Breno Leitao <leitao@debian.org>

