Return-Path: <linux-kernel+bounces-843279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD371BBED2E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4800F4ED535
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE2246783;
	Mon,  6 Oct 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z4ZPlCwt"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC823BCEE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772148; cv=none; b=d9gNzHfwLsWh5jMNgsP37Q7D8QVD9Ixf5G02OLFH4vVEaZZ8st/NEQ5cpjf4uy9KRxE/422Xi/fOzIsUJE4b7MJdzzujq9hcjXbtQpx2uy8js8Osi/XJUzNXjlZ8nLNLflwatCJaDhNxIur7OkFy2i85OcfyzzWpBTpS0p+INNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772148; c=relaxed/simple;
	bh=W195a0snK2qbMlgwvRIrKSLXzC/gj1N8SicfYvXdfZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3UWZsIlTTqdnU0HdT+wk3gNDV+llu57g2w9GoRpfjpNKk7Tjy/DfGgPniM+D7Fg79Pd5wMQO0DJg3uIT+qQ+VfSPk6VvM58Yw0Tw8rFJVP6f1GZqcBzofi1D5UbQ05OsP/DPc8eYepVW87Ow6UgJbBoNyxJHzVknQcMSIzP1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z4ZPlCwt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85c66a8a462so762269285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759772145; x=1760376945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kR53Dw5KXmac3PH9uOCTXtwUd6vhGp4REIph22KJFUU=;
        b=Z4ZPlCwtMh0xurcLXNb/8qEC0lQS3m6nbc7H/qFd/DjHCAUgtB/ni5p8xXMqjl3qzV
         7SBVVuBSzceOTzvDSnhGl4MFbiqqMOivpTQdBYR4TtqAm46EpSsknaurxjAj9FCFr0/j
         C0vTgisGf4SLsrzTO/fzOYipz5SQM7J3xClyEHjc2kep2Vqy8dKz95qv3MKSxYzVU92s
         p56E3NTYMVAv7e6lBH8NhYgvMA3XBYDM2sGEHsFgzxYt4i1NwKapup/0sfGObM9GeNEt
         34fc/8LaaHkRCxt3xeLGOZyU23Upg1gSVpVe1R5jBCQeADPqhv+4Pu92Yg4RrqEgYEDu
         mK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772145; x=1760376945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR53Dw5KXmac3PH9uOCTXtwUd6vhGp4REIph22KJFUU=;
        b=v3UCgnmW8VPQYLZbeK+Kqdv7aNlmQae6wmbzQ8E3rF/7D5HBPrg1aDN8LoActSGLYc
         jm/yjyRwQt4zGvTTUuhXZ1vrgHuz+MI7+yJoJViyi4GOkqdm7yj7pTlh7zeJ23JR6iQc
         VNeS6Tn/kcePfmAz1PRFV4YLoywPIAALY68WYrLMFI/nNTT0lS6OJiK9rN3437Nh3i90
         Xam2yngsncwwCX003+/vxbV4kB0M7+FGlX5CDSvz0UfRFKur8j5XmuXMtIq+qBy19OAB
         h/7gX3MyjvDFF23h6NXXM5V8n0JJj6AFGvVV1LSc25PpfUJiVxixmT9iF9VgCpujCKS2
         u00w==
X-Forwarded-Encrypted: i=1; AJvYcCXmeGsO3xGYqCoDugKY8+FXJugtg3CrhZH/S7I5C7oXfKiDYBbIlrU4g/kETKKOXJtlgMjRZo/E7y84uk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XJXhiFHuUkUNwGBfkTBY4u+O95LhRelHZOma1bVp093JF6xT
	sv/1TNpjaKdmxNYx7uPuSQ7JZp15wVBQChV1riSniGsfSgV0UOpO4TFN9nnP42qaaQQ=
X-Gm-Gg: ASbGnctV32DuJ6q0zjAzuMECqZqWUw6Le1TgoW8zEi/SxTf8H1xDIU0JaOM+17jQySl
	9Cep0yd3AOQ2vw1NFk/wtRDT10alAUvV/hkacuvs/awf/6LayE1LDmH6CwUoBC/Wd0g7sAquosG
	NL4kW9JNLnJR3Rn+olrL+noxBsTYXFE7zT+p6q08fHLv79upJ857Vd8ADuPNjN1DifgS3q67/5E
	5hmVAwffkUlUR4FYWCW16aFy3xUv4my/ROwNS7cqqj+lBaQSDJP83GqAtVkkDeI0imIX3gSy78n
	Idhougw10WCdcpoUjZCWkO1jqoaIxRnh/v+F7VQ5FP9ZnxGFmbZovbsK2av2ByZiN2kZAEp8M34
	+EAf1mBUBOubFRbwhoAdR6EJY0VXCScggwASN6R/zAzk3r9kfOl8iz/7DLi0NONB+9Ivu7HEwZ1
	8FR57/jlro2mhhMemAz95JZjHp86WaxaHaVp115PXm4PJggNcBf8k=
X-Google-Smtp-Source: AGHT+IER8DoXpPhXVe8+Q8xupePoMW4LjKc805ivgHMRBIcpH9k3WI96ovGNcp68qp1cCNFhDqppHw==
X-Received: by 2002:a05:620a:4154:b0:85c:bb2:ad9c with SMTP id af79cd13be357-87a3a34d280mr1467487385a.53.1759772144584;
        Mon, 06 Oct 2025 10:35:44 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772460ac0sm1375860885a.19.2025.10.06.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:35:44 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:35:42 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 1/4 v5] cxl/core: Change match_*_by_range() signatures
Message-ID: <aOP97tRkOhXmmMfk@gourry-fedora-PF4VCD3F>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-2-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-2-fabio.m.de.francesco@linux.intel.com>

On Mon, Oct 06, 2025 at 05:58:04PM +0200, Fabio M. De Francesco wrote:
> Replace struct range parameter with struct cxl_endpoint_decoder of
> which range is a member in the match_*_by_range() functions and rename
> them according to their semantics.
> 
> This is in preparation for expanding these helpers to perform arch
> specific Root Decoders and Region matchings with
> cxl_endpoint_decoder(s).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

This may end up conflicting with the AMD ATL patch set, as that set also
I believe made some changes to this area.  But somewhat irrelevant for
the short term.

Reviewed-by: Gregory Price <gourry@gourry.net>

