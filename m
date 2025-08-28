Return-Path: <linux-kernel+bounces-790189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D4AB3A1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E92188D996
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749E24167B;
	Thu, 28 Aug 2025 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTj8fa6H"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1023182D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391403; cv=none; b=odqcdfu+/OmIDMPFUXJsuy0aRIFCoYuQlJElsws78hsUFHCcE+I2i0eYdm/Qsu6v2z914ToSxSFbaUn/yhgagsSB08TU1VkBXe6HyusA70yu0SBdw2kv/6mHW47N9/IxakDjzhd+AIbl934i1fx8aFvqFLVfskQsWfbEnneIMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391403; c=relaxed/simple;
	bh=xuHALRSB2lh3wzfyFYdypwQ9WFcxa7aaFkET2WvUz4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujMYwhLGmUASa0u6tSMLqZCjQc8dvCZK9MlzeDMs3J0p4CYpaZGja7zdWbZntkCUiP10oL8SjqHzKOtxbWh4cuOYpe6PR0ZBtxnuYxEBRnfFtwWDDnU5y32UDHyPpV03htly5GVrA80K1BY0gG6otX9e7TJbertTJKiYR7hKm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTj8fa6H; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24611734e50so181405ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756391401; x=1756996201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llJ1M4xxxeRjXKYFSOXlWlEyAgEpbCFW6TAfAztxyRI=;
        b=mTj8fa6Hs19KPTA2WjzdXJsNzlczhc9U6LqZ57V3M4dYJ30C4bhXRXMuQzWAVZ+8XT
         8s+DqPaDu35jp8r4r5IKUsa0lDRrTHvuxR3CCOvOFpkp8RnuNJOXI+GWUaTbrkuL7w1F
         FlZEoqbOiloC6QlOSLH9+I7zI2V3i7WzRu4cNLZkYox9y8aAAruQ4qFwcCHt1wZ7yZ17
         sL0JIBysPdgU0GwsYsiFw0LdkKjPlDmncvSN1c0U6e3dljBpTB4P93RsO/9BWSRaEd0M
         Lj7X0BP1T+1PP7h/NoQ3WmDLL4YJuf8uaUgk0LEnpnKlnS9F6qWOSUsu4jDrIWjk4+fJ
         CwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391401; x=1756996201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llJ1M4xxxeRjXKYFSOXlWlEyAgEpbCFW6TAfAztxyRI=;
        b=LbFL9JUHiw228WbxzMN4JUDgUR9PN+uSINOz/erY+XGTOK2njwGKrAIp/tp5YEM2Dq
         JVkZWHTfSFbRkBVMZSmNJ0HlEy/e+ZC3ULezb7FQk5QS+k+4G4V/xah1qudBMMHnHjYk
         U5F9S+4QuTxoYR6xtvFzUMQ0nZjxVcPAdJQlzJyrEbTVksCQnhezlPCHXUbD2sGzvMrv
         /8Roslqju16AEnJiTEGUx+eraPtDRfZ8Zury649rh5gnBN4XwrtzI6HZRmUspkKPzkUH
         KYZE1NsJ4ZpCbshdOEIzIRY33dGAXidldPJIqRwauK5k0LZD0Ol/N8hYPaRPhOogKPL8
         Jiow==
X-Forwarded-Encrypted: i=1; AJvYcCWqR5sUJDcQWmd0jV4HN4MI0vql2JP+Z+SjKpIsR8MSO+a0Ur7vkHK1JjsvGx1QbSkxTKhwGE9AMXZkTp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BZZpx3xV00/OMaFmzWJf/Nz80+i0Au4Bo8V4ePdTxfuX40TC
	jk4sXkKOd4Gr66QiylsX4n31lLZbx86I0OyzPPn10wIPO5xXL5ju06xev3nbjMXqXg==
X-Gm-Gg: ASbGncuoYba07vTrMCV+7jwPrPKXbB4g+eXVvf2mpqAdiE9hZH40DUCWQJQVUNTXyhD
	vZSOkRr1lOh9marIo6yD2+8t189K6LgqjAr87hGH5c9wi/T0n4Nu+u7dqoHYipZpw3eFiQRSq7o
	lGNEYneusyn/67BdsOWvys4pwTBiAN+uV4EiNRx5eqXtBEccnZDnkYIHdkIEiSPPJY/UlrhEt+4
	KVQtJNJZMSPKSCveS0em+Cp9MwmAvvaSOsxRRDj17mF8aHdw43CcTDlEv90x8ZugClJyFbUOTQ0
	Ar7n6oLDcfNihiyptTZ+jLaWApq7M/owt5bqCxGsavczGqhmYJJnW8jcHnJLvc25nq8TkXL6ykE
	X4znRtQjK8BZ20hGXkKY0iZANd50gTh6GkTUIcdTDgLGRzqBA2/+/R5WFKacTIpX6wjVirW6G
X-Google-Smtp-Source: AGHT+IGqnjMUnHwbY8ZYK4ZrateHqnkIq/oBjnMDFO1wIh4c+rK9agNtu2KOniT/7Fx7O0+N24b8zg==
X-Received: by 2002:a17:902:c40a:b0:231:f6bc:5c84 with SMTP id d9443c01a7336-2485bd5ad00mr16238015ad.8.1756391401204;
        Thu, 28 Aug 2025 07:30:01 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327ab094f00sm2684545a91.6.2025.08.28.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 07:29:59 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:29:54 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	"open list:MEMORY MAPPING" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/mremap: fix regression in vrm->new_addr check
Message-ID: <aLBn4vb0Pmwoqt51@google.com>
References: <20250828032653.521314-1-cmllamas@google.com>
 <8a4dc910-5237-48aa-8abb-a6d5044bc290@lucifer.local>
 <53b938ed-dd78-42fa-8cde-f3a938b6f39f@suse.cz>
 <b58449cc-022b-497a-97f2-c91776d133dc@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58449cc-022b-497a-97f2-c91776d133dc@lucifer.local>

On Thu, Aug 28, 2025 at 03:22:54PM +0100, Lorenzo Stoakes wrote:
> On Thu, Aug 28, 2025 at 04:21:05PM +0200, Vlastimil Babka wrote:
> > On 8/28/25 07:38, Lorenzo Stoakes wrote:
> > > On Thu, Aug 28, 2025 at 03:26:52AM +0000, Carlos Llamas wrote:
> > >> Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
> > >> checks") moved the sanity check for vrm->new_addr from mremap_to() to
> > >> check_mremap_params().
> > >>
> > >> However, this caused a regression as vrm->new_addr is now checked even
> > >> when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
> > >> case, vrm->new_addr can be garbage and create unexpected failures.
> > >
> > > Yikes, sorry my mistake.
> > >
> > >>
> > >> Fix this by moving the new_addr check after the vrm_implies_new_addr()
> > >> guard. This ensures that the new_addr is only checked when the user has
> > >> specified one explicitly.
> > >>
> > >> Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
> > >> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > >
> > > You need a Cc: Stable.
> >
> > No need as the commit being fixed is from 6.17-rc1?
> > But it's better to use "[PATCH mm-hotfixes]" to make sure it goes to 6.17
> > and not the next merge window.
> >
> 
> Ah haha really? I'm losing track of my patches.
> 
> Yeah sure as per Vlasta then Carlos :)

Oops, sorry my v2 raced with this.

