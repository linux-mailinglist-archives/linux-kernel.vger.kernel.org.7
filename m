Return-Path: <linux-kernel+bounces-767743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E0B25883
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F6D5A5EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721872623;
	Thu, 14 Aug 2025 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuVY+NOM"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BB54774
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132201; cv=none; b=oYqYCj0xC+qR9OW77rCsA4m1pBjfv64uAc9FtnrycbGSMAbGSnUFCcS3kKKdYc0XaETLJKeFjKPaDg/orhcSVOJxgm7/aoybpInMGf8MQ2GSTLe06Dcn1UxjtnjfI3VnhK5Oqj3wBJfOtn7YLdvq9T6coIqYrn0dV8RlofFzF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132201; c=relaxed/simple;
	bh=JzYwdH3GDLM/8j8Pp0EevyE2d7KXYa2T377xArI3f2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWgs21KzejQMjTpX06Uolf7wHnHi+dwlslvrn/D04Ym2+1lXvErD79UmLBpfUrDcbP3ypraJGEu0uOlmKI9UrTsoA4COaxTiQhK8A3V3093dfCY4WodRO3N4Cs9uGxJpMAAdboUSXS7v5zGUhVhZTWG3wK6OduF0YQC8ZXxsQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuVY+NOM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24457f47000so3023835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755132200; x=1755737000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+C5FMfkso7Ehl3CDtEbjqMlL+jBCATLbsthyMiqNTA=;
        b=AuVY+NOM+NpHxRu9WvjVRyOHuwHSJQkJZbwYtPkK2QTAo+to8khtuVktVu82ENkpiv
         DaMjfnxmqWb8EqCuNkohLj3/+nr61SFxuWCu9wipEaL3kntFmvqalrKOZG5gU287SW2L
         voUNcb+sHWnWZ4R3AG+2mZxH/wfYvyQiA0PxWc2dJBeXdFm+vBDwgi9pjn0cDHTrps0k
         BMKKYVFp7KD40Li6wyY7lidMh2XLUyAkxYnNLEsvjelHjUTCNPO4U9jHzNPRJzy2uuW8
         gnU2ofE77GrH6fJItFZD8egwVlzsbf+AcB+NYMx+DzeKjEW9jYhwAVa+LdUhrmKxxyh+
         sTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755132200; x=1755737000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+C5FMfkso7Ehl3CDtEbjqMlL+jBCATLbsthyMiqNTA=;
        b=Cy8cnMtxpj7UadgwycFU+/sIfURENLNvPaSZtVQ1zxQ06uNZGPgAycNrO3b44su8qx
         9rQwj6GLPCHbnePxB/F7zaoJXdK3EWIdNGbO1Ub7cp+CxqcowyKCo/fu1kCUjKhvlcBE
         iG8tnp+BckB8jAdFmh+GBx8Ed/wz+TM094OGMB9e+TmfL6WcX7YsrMJiYZN+avuHvqHP
         ulcuvAnuiPUdGpe4dnE9c/mlbgrUHFh5h9Hr62bknAAS0v3saBuyW88rHgsOTqZ+xCjf
         CddadG5NsjIDzfyObAdoyJiaFEgvQ0CXcrzcLaSxt2EaQLPKhoFekfD+o+Y2zP8ffH59
         etvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwZBFtjrA4I6noAQlYzIElklkNFnBhyOkr5HukheDL9safiD1vy64+gk3bduMZcptwmWgKEZeyL7y9Lb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHuucLrPPTmDPYk1RvZ7nsyGFoUvCeA1evumGEbrsC2WC+7Wj
	VpQ2jDHzT229hyb6CFqwRHH9gf++hGnWPBCT9+kbYcVpynWs3HERuAUl
X-Gm-Gg: ASbGncvu6bKtpux4crnodo8/NhEaYXy9zdPmwEJUdhBguq5j5OdpJYSIm7Q2DjkvOcI
	WyNb8YtblGJY0KcImS2BofWtskzB7hoVSqk2MJ9PFj816RYup5AeYm31Zn1vI7tnXwjqSPy8+Ta
	589QYjQPHS5+CUXb60s580OJEoWwzFj+V0DUqDbUhygOpthgTqbhF1rPrOEOs+I9T4vHY1qFdV3
	bDgyJStnrrsS4aGBeFxtMFD2eDawkNjgs+SmdPU7br1I9UTOnhSN4CnbqJKnjtpZsICxJifJDI6
	ITSgpeSjux9ZqwEyQrDaELNc/xYLf4hxAP8EDcKjhvcEBLtQc5AwfU/R+R+345KTQcIDSAviOij
	pGUte/3TaAmHBN67T9Xd2Lw==
X-Google-Smtp-Source: AGHT+IEiVLFQ5wPPcPeCPkCFJiPIhTF+L2wnLKcVZ8kQ7OVLRd1oTgrhJtB0ONkLIOLfiAtQofJh5Q==
X-Received: by 2002:a17:902:f602:b0:23f:d903:d867 with SMTP id d9443c01a7336-2445868b44amr13421015ad.35.1755132199683;
        Wed, 13 Aug 2025 17:43:19 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2438de0a660sm22394765ad.164.2025.08.13.17.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:43:19 -0700 (PDT)
Date: Wed, 13 Aug 2025 20:43:17 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc: pci-ioda: use bitmap_alloc() in
 pnv_ioda_pick_m64_pe()
Message-ID: <aJ0xJenyDJcZILt-@yury>
References: <20250811165130.37552-1-yury.norov@gmail.com>
 <20250811165130.37552-2-yury.norov@gmail.com>
 <b1fe7008d2f230dd89be6d2541b7cf07ed2514e3.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fe7008d2f230dd89be6d2541b7cf07ed2514e3.camel@linux.ibm.com>

On Tue, Aug 12, 2025 at 11:07:08AM +1000, Andrew Donnellan wrote:
> On Mon, 2025-08-11 at 12:51 -0400, Yury Norov wrote:
> 
> > -	/* Allocate bitmap */
> > -	size = ALIGN(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
> > -	pe_alloc = kzalloc(size, GFP_KERNEL);
> > +	pe_alloc = bitmap_alloc(phb->ioda.total_pe_num, GFP_KERNEL);
> 
> I haven't checked whether or not this has practical impact given what we later
> do with the bitmap - does this need to be bitmap_zalloc() to match the existing
> use of kzalloc()?

That's fair. I'll send v3 with bitmap_zalloc().

