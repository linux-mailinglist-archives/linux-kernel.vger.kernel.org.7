Return-Path: <linux-kernel+bounces-854922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150C6BDFC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965F84819DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3232BD5B3;
	Wed, 15 Oct 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WGWnwrxE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156D32E74F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546972; cv=none; b=NRdF8+2CfepIJ01hTX7mC/NpzZIDVxZdOTy2+z5Ja8bkTmkL70QahVmK/QL6Y4sXc0fDcOsY0UUA2/XdRL/PX2pm9zZqzVcEuUBpHK6ctRBRWhi7wI6YmRs9r31yPnG05DTYlGYCA7L2jCJ2S6BkpyNTdgtBBrFSLNR2MxFI+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546972; c=relaxed/simple;
	bh=TCZeHuv6Pjsy9fegpMdRUcS8sHFaN8cg5UnQkRiajwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU5MOc0LQRSJsR6k3oOFc3n3t7Uu55YorZOpppXbGASBTSuCB8U+JrkojewQiguocsfrYv34+iD6cx4gJY5XNY+tC62rq/p4nMvk2oXhdY4FCUmMFK0bMOdKC5DKqYgDX0xmmLLs67VHD+6avXGDih/g4LAFNx+t9Dnn8kjjqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WGWnwrxE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so78588265ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760546970; x=1761151770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCZeHuv6Pjsy9fegpMdRUcS8sHFaN8cg5UnQkRiajwA=;
        b=WGWnwrxEMjYXIDDchjN0kiL4A12pYiz6ZFBOghvdQMr/jZaReaO9a40ooWJDU1aKNL
         DSHUTOgyo2Ggk1qf7B/JlMBELG9ljl0+iYoZSXJUnGwNeInJSSflW9QhBPT+kfeO3J9Y
         3ldba1VXO9lD5ACvfiwMYfKuFb7X/ifVVh8fl4c4kIRFcqXkP0EtZV0N/lS7lRUvG7s8
         mIPPdsLTsjfB+a1tRf0z3WAQuyJj2jz1Xtinr/w9RvlvqepXCMQiJn7/OJeNv7v4DQpX
         ByfZ8bdlp7lFoRGyBSOtTfeIcF73Fl8E/vMFPdmdyXOr9WNVJKKn8XzTcHypNO2CNtW1
         uSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546970; x=1761151770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCZeHuv6Pjsy9fegpMdRUcS8sHFaN8cg5UnQkRiajwA=;
        b=M+4o0trnoG56YamiEOASxSvVYETIuwnJCvRv0o7s+59L4abY0+bMBbxR0HWNivawOv
         7/CA5snCuOTO8twulyYcbZ/elc8n995rWPscTXdLwWdacmTA33GC79vdIEpEJ8/Tp/29
         FZD/V4IxR8oMb2BmLmeciDmTgHTRdymjbtyU/zOW1Eln+NeSH2iJ4eKgnHHTt0f2FBC3
         xbZiEfYEDELlUvvVqZdOrJzkKmvbOfxlU+iGOp3uJD+5of/3t/be5ZY0WjzKfPpzROtD
         kVSOhCnuGrkuEjG0qd7yVDOeRFLMbDciKtt6tljHTIIVRyPwn13XN6n94SYHqLgDAAQy
         B/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXVyh3WwI3F8zL17ZMkXeamCePP/W1OO5Ja9Exw92H5kTdGBIhLF0+iEnaaZT9opYNqKoKuVG+m6QFgiZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmixVLQBdn/C4EM06uSEtaZ+tJ1GWOvnLWjQcUqNkZ78Sb7N+
	Tydlw9eDbQYQEalTeRosv3J8GZRshTaAElffoaC6zScQxjrRzc75fglYsi7j36k+PMs=
X-Gm-Gg: ASbGnct7MyuxzuhJHjm0qYSGI4cqrQWHwqInncM+teuGxxILqb0kZd+KMb30mt6N1h/
	snnmhmGpZFjZOlRzKtYJzY6lBjcwxSSTcAq3A7Zvxk87l41haR8E4BtQy5M+WC938IWIfjdrkwU
	aUwOqoF4zvOuveyXTbMLJONKKXVe05H08XUwQQzYEUGWkWurWafQujj0kHmIatc3yao/bMvqZej
	dcI6VcmhbK9TSNAONcOjG4lNXJJjKLG4klMvZtbTlNvlq8pbuXoycBYPGYeuvG+7yCrx44RZMZA
	tUrCPaCIWwGVLVYryIcOTEFrFqSo1euVZd2CbpBI0XqmFZO3rKKKImZKOKKdBFvV2L+Fm4666HC
	e29vAObRQfAG4dlA=
X-Google-Smtp-Source: AGHT+IGFHdp/Htwv0bzE8x/j+OgvneedlOjctqYdJUlPqsUPgdIFtAyyDYV0ITQapRii8sWEriy12w==
X-Received: by 2002:a17:902:d607:b0:269:8f2e:e38 with SMTP id d9443c01a7336-29027356528mr375808965ad.6.1760546970533;
        Wed, 15 Oct 2025 09:49:30 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afdcc2sm1193335ad.115.2025.10.15.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:49:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v94gq-0000000HSF5-3X3l;
	Wed, 15 Oct 2025 13:49:28 -0300
Date: Wed, 15 Oct 2025 13:49:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Jacob Moroni <jmoroni@google.com>, Leon Romanovsky <leon@kernel.org>,
	Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20251015164928.GJ3938986@ziepe.ca>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>

On Wed, Oct 15, 2025 at 11:38:10AM +0000, Haakon Bugge wrote:
> With this hack, running cmtime with 10.000 connections in loopback,
> the "cm_destroy_id_wait_timeout: cm_id=000000007ce44ace timed
> out. state 6 -> 0, refcnt=1" messages are indeed produced. Had to
> kill cmtime because it was hanging, and then it got defunct with the
> following stack:

Seems like a bug, it should not hang forever if a MAD is lost..

Jason

