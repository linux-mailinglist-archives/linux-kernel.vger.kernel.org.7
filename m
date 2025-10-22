Return-Path: <linux-kernel+bounces-865760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F82BFDEED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AB554EE079
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5834DCE1;
	Wed, 22 Oct 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw2S3SYF"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A328D83D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158944; cv=none; b=TDd2CTdXgGthFLBDFA8HeqJF+NZe/Sgupf++L4TZ7tzBSZYSMIULLYja54a/JDKuFmeN4rddDA0Bg+lKSvolTJnJMaIv29jbciH/Omq4Gxm+v3FEsyXx25hvoMw9rfmxIW8PssrWDeIGMzxgk77gxt9sHrfGdOYy6YImozo5tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158944; c=relaxed/simple;
	bh=kekmjW+B8ryXljeN9A/G1hnwCWmHWlgQrFugxJ9kU90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhxMCSZ5EzANqZudUDq5NTHnDSAI5Zeimnbxwf1YY21RxVvSihb1zFFvTfYi+2v3mcufTqHYAsTX5glwhojrXiiohH28M960S0bENu1Z0/K90ONXuPpGQQegdt2d1yx7QehMJEz8OFClUn/YPBxqp4HhqCBxSpw3uX4clAIFf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw2S3SYF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b62e7221351so6096261a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761158942; x=1761763742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62UfZS5F7RykOi3+nimErD9KcFsbI0a0R9TN3A0g8so=;
        b=Sw2S3SYFpziBt/BDZeqc/wC72OP8CVQY4tQge/NN/KAqZYB1zXQN7bhzxV/vfQtaCZ
         2VEIDqa58KHfWRuHn2ohM9CZ9eEzo/oApSrAPzJZiFaJpXa5zuQlue/K7rS8EV36LWdv
         GTXJn1C7Qeni4UAjFtFxnjYf6gJk7RjYTAbOoIhvXD33y7+aTJDMyfMbo4T3fkOz1oLL
         J1vJb51bOpSQW1OlaO7wtFI5JXqTdnsDxRDmppYW5TkBFvNPt5+xhtfh+Bb25SNcyHb7
         o72nVpjU3N4rdiE4JqeK+Q125+caSASQGVBT6SKvFpK1Xm5IlQ4SATsuxL8uBC59KYOJ
         vWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158942; x=1761763742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62UfZS5F7RykOi3+nimErD9KcFsbI0a0R9TN3A0g8so=;
        b=K28ES7KKzszukUBldy6v3CQDLK8Wq47Bd5fbwcckvR8fBCuvQmIDYHaLNUWSqzYO1I
         /60LwfU6xBELuTwQzyg9Xj154Y83sx+zrH7FOKOylDwI+XkjE4uq70+RoD1SfOJxUyhL
         afcjVykA8VWAFcGqw7R5W3oodKx2qsCYA/qKOCnDiX6Kk/ILwJ75L+ytu+XxLBoKJZAS
         GItvNE9ZPBAW47q4zTSy7qPwLnx/8mFVJ+G+Z/BKGV9HDJ6EQBf3pSPEkV9JzS7FDOkr
         556iTUcrxsDMluRqVS9BP0cNNfMyygYSCWX2ddaYkH5ClTahUFi74dZqlsdbvYDZJj3E
         llRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUx7rJAY1HpleIOaz+2HkbHf75MJ/7287E3tf7aEiCJ8Thl6SVS5x3Ha6EyMj4bmx2G7+zZ+25rpdjbjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNC0NbvI7ktG4Gu3XwzsbelZnUxAcmqwShu2GqaPokxZiMMij
	dH5R89UUJqTc6gRKkZeltgHOWxeoy1QVM4T/rlf1xgmTvE9r9BUABKZw
X-Gm-Gg: ASbGnct01CWl/ScsMSGFZ8rtSvVgT6fHbm2+YO43Ix3hLIDyuVdBSexzKNy21l3nUXV
	LuTRTU1MtuIyF2ixy++iCWLo1Xb0NUzPfUeHWY+eY0fUdx1fYQnNGnNOESC279TqF9U9wLSyklz
	gGCGimWP69NqYDHQbCLJsK8+4IzihRFFrwKKxZUqVBG8+tOkCYFugzhnpIY8CZEa3PooqIjFzN6
	rU/Ka40D6vWx9GObYCJvcbeEhtPM1y/A95B8PZR408wykDTHCeGmUxmkXxE63ZFEk1xY5/GLbNK
	2j5RRg8VdYkjtddhmIxoR0AyxbuGzio0UgU1lzJWmcTUBs3w+GPJ+1YlVjq5AY7rDkGvs6VKRcw
	NTe6mxTyybx4I7JhdlOKBZgKNj6h61OmGNpGK572hWPfXzZb2JLWhfQbNhVB0cRgZmX2tyaXaQY
	8L6cG5bTp/ppdjtu8ADyGY6pmSCqOM8k4IBtZ5NgI=
X-Google-Smtp-Source: AGHT+IEQcmU8eKW5Kc7s/g2KbityDDlERhx6OrCJ8DT1lZJNQfHIJw6EGlEW1UNsEQZmRo1hEFsmUA==
X-Received: by 2002:a17:902:c943:b0:26d:d860:3dae with SMTP id d9443c01a7336-290c9c93ac6mr266089855ad.3.1761158942307;
        Wed, 22 Oct 2025 11:49:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:53a9:459c:bdc:6273])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193dfsm144472775ad.105.2025.10.22.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:49:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:48:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: akemnade@kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: add TWL603x power button
Message-ID: <viq7cjqmt7guulqbuliismflq5gxtfqrxj7vzn2goctlcn5zlt@vaht6usiiedt>
References: <20251020-twl6030-button-v1-0-93e4644ac974@kernel.org>
 <20251020-twl6030-button-v1-2-93e4644ac974@kernel.org>
 <aalnnbzeajxgnq33go5b2gi72yjzeeun5f2pkbdulu2hwuz663@b65xssnkse7l>
 <20251022144422.7c17322a@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022144422.7c17322a@kemnade.info>

On Wed, Oct 22, 2025 at 02:44:22PM +0200, Andreas Kemnade wrote:
> On Tue, 21 Oct 2025 10:58:35 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Mon, Oct 20, 2025 at 02:31:59PM +0200, akemnade@kernel.org wrote:
> > > From: Andreas Kemnade <andreas@kemnade.info>
> > > 
> > > Like the TWL4030, these PMICs also have a power button feature, so add
> > > a driver for it.  
> > 
> > Could it be integrated into twl4030-pwrbutton.c? I think the differences
> > can be accounted for via a "chip" structure attached to a compatible...
> > 
> So what is different:
> - different register (but same bit)
> - some custom irq stuff for 603x (so if (is_603x) needed)

Right, why do we need to unmask the interrupt by hand for 6030? I'd
expect this handled in the core, when we request the interrupt, not in
the button driver..in the core, when we request the interrupt, not in
the button driver...

Thanks.

-- 
Dmitry

