Return-Path: <linux-kernel+bounces-878313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82CC203E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC81A61489
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70D22FDE6;
	Thu, 30 Oct 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WgF54Bg0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6519207A20
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831153; cv=none; b=tA/3u2eClGwk3IMtwNr/6b91pZ3iL7CNxXzml5iYHLq/TMTOrvL4FGHmAB30foYAl0p2w/ZKSyY8e46VZCXNNB4RNSaTcmqOXN6Sbc2gRG8eyfyWVUvCWuUaF0AuI84JZwrYftfzhIWlKfsBs8Mm5hBX+HPTQqOog0gg5Z5xiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831153; c=relaxed/simple;
	bh=m/A4VCO63AR8at5PDahUOD+LaF569oFFFLdpzO5iaoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIsdCMrIgB6Tne3VTfyBn05mfopcViVH6bZPpIEEyVQpptnp0zB7+UGcpDIn2TVUrM55RB9nBy6LJ/MnzmRpTkaTOqtvFowa5H2UmYJ/o7bzeFfpsNYbQYw96b4kbO21pvgNlEZxXXQ1BI7L+hrESOZgjO8A8lhqNjgXGTVsSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WgF54Bg0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c21bbdcceso173757a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761831149; x=1762435949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtQl7nZ6TBzZdXHchWa3vh+730SdPYteLuoJeZxfyQU=;
        b=WgF54Bg0JhZSlcNSOnXYOfhALX6uYNRDC3+vHI9+fDiy9BYwMqVy9l9AajBGAjTy2x
         tNsnYtzYIRmIkZ+rXkB2HEkY8n58bl9Mh0U/nz/iZHiJ3OGqpa4GBk6irnQ0VecPg+zH
         ziiUgzCiudDPWkXPDiY//+KeHcle2sDWg/kzUhM8uFikf1QK9rpZTRdNWFKYyOKUrcM5
         68FIRgIEOO7eN6KcOCA8tirgbdBkhdn8PDnpuaJp8wsxSarIuWjAeS5bOHGZZHC0B1EK
         6lzlwsvbQzOgKSiidliq6hNl9vbodwiEigUmBROYQfQsMANGeXqr/oUdB/S+Yc8GZcGT
         dH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761831149; x=1762435949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtQl7nZ6TBzZdXHchWa3vh+730SdPYteLuoJeZxfyQU=;
        b=Ds8Tl7c5JtY6whOFAwUsuIjC2/hIsgPmr1uIviw6MJN6VSEZGOa6GjeQ8UqtYdDhP/
         cbEzrERenKymASBnqT64ibLDiSWJT9Lqi622Av2LgNNVE5OGums+FjRVC8g3eepBvytS
         sExIoY6Ozw+5X0keem34h9OCbZX30XLImoU52w1x3djUpQLhWCdNW+DQBBepm2MVtP5H
         ifCW31+Yp6+aHcR4LvT8MWEMRmxRQH+9qGTpAypyYzhe5xGB/fjDteCIqGZKS6pCZk0l
         cP5/BYbpeHjopyIlNRapfJycv3/MfHee4BQFxFV+J1OibNiis9ub3FrYYHUJZLeKTBsT
         JRsA==
X-Forwarded-Encrypted: i=1; AJvYcCWBZPrpk98cbXMNiKtvdIccOzrqFUg9TPM+XX+/AdJ2zw1Zd/Q/Hf/DYgNSPFh7LcOfqN07spuMEVgggF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRZhdTmBysA8QTyQKXXReTBnT+zBusM3sBIHBNI/r0btkvDS8
	ZRetfs5CVJaKCdi1C031OcICyelMH3dO3qXf2IGyABmOMmyB+Ki3reyBFr0916tq/zU=
X-Gm-Gg: ASbGncuB+diruKNSUw+DUKLRX2H0Fee4lBRVQ+cMB19Mw53rR4Lw9bu1ui+lxXFtUBy
	f4eMnqUnLbqbaIhwiw5B6UCzm/veqiM9VWpBO+4A6/Df++19J7qMEf6k5Y5fdFXFc+Dbe4fU0f2
	m/vl9H0YKguKCniwIdUnspjUHmbUomCQX7fGSefCQCTtGfKsF71C9iq2wQslynv21HdUSJDM6qU
	+fvJv/nTZQySViJusA/Kc3F5n5O6Q+L9bTT8Z/iCqDb3RTvRj0j32aCmnIFgegsK/PAthdSOpf9
	nbFaOw1QNHMDa951NfvClZWnr1cnWajF5y3yyqWu+qqymNKBB0TgOCumKRm7s2hqOMtz5+6XLx2
	JOBXYZDnqaG8JLzQMxxI65ivoO58puwqMCnwVaVR7ezYVD5C3Ry1UTH3ouyIH0Ec84HPyvto8LS
	S9fKoWtBeQvZJoBxdDqYiIfS0IiH/0U3bBlY02k/i+B/mognR1QMgbdlfRg1TBoCf7LQ==
X-Google-Smtp-Source: AGHT+IHSGEOvYjfz31tHH/a6U1P7PjQbpJ5lLtdmmZBnBXACF8RPqIWku3GmTxQ6eZGROIpWePh0aw==
X-Received: by 2002:a05:6402:42c2:b0:63b:f26d:2eab with SMTP id 4fb4d7f45d1cf-64044195dffmr3098104a12.2.1761831149005;
        Thu, 30 Oct 2025 06:32:29 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64061a5b7b5sm2281942a12.1.2025.10.30.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:32:28 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:32:26 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, David
 Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] slab: use new API for remaining command line
 parameters
Message-ID: <20251030143226.4661857f@mordecai>
In-Reply-To: <aQHx_vx1ElIBh7tq@hyeyoo>
References: <cover.1761324765.git.ptesarik@suse.com>
	<6ae7e0ddc72b7619203c07dd5103a598e12f713b.1761324765.git.ptesarik@suse.com>
	<aQHx_vx1ElIBh7tq@hyeyoo>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 19:52:46 +0900
Harry Yoo <harry.yoo@oracle.com> wrote:

> On Fri, Oct 24, 2025 at 07:06:54PM +0200, Petr Tesarik wrote:
> > Use core_param() and __core_param_cb() instead of __setup() or
> > __setup_param() to improve syntax checking and error messages.
> > 
> > Replace get_option() with kstrtouint(), because:
> > * the latter accepts a pointer to const char,
> > * these parameters should not accept ranges,
> > * error value can be passed directly to parser.
> > 
> > There is one more change apart from the parsing of numeric parameters:
> > slub_strict_numa parameter name must match exactly. Before this patch the  
> 
> nit: ^ slab_strict_numa

Indeed.

Petr T

