Return-Path: <linux-kernel+bounces-844040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736ABC0E10
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145AF3A3BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC22D3EDF;
	Tue,  7 Oct 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQXL4SmQ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D582561D1
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830135; cv=none; b=Zebv0khVqMB0Lgw4vyoIhOTaBB7sOQcawwxfhhLc6Dt+vGTljgqsaNMjrzFviMoFurjlgz2aQxi8KAGHsBHZVl2bcCu3cCMq4nswNVMCBbOmJgiCOqGRDv5PFs8KrwicvVErz/a0eybLPrq5hedMu3pzB+q89LzAaxsJxst8EMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830135; c=relaxed/simple;
	bh=kHv8i7CcXlfEouPIVwiT0wm1gwOeZBHTH1rvLUUUhOQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okEuYtfYKS542tocNyVlkqAz72dvfdN6OSp353LnG7ov3bo6x4sgHvxLWS/wfXOQG3pPwMhQmUEjGs01syDb+rEl0au4S0gvLHiZ/aqYy+DBYt65ckNtS2quNGisOdCaPKg78GjUETYMfXK4ULzNm45K/Zy6hl66frlvd9KLnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQXL4SmQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-36bf096b092so57420451fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759830132; x=1760434932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbTmSFrTbV1O1JezcHCIzpAuTai20RptyHEWwW07HhA=;
        b=aQXL4SmQHtb9Wrq40GY6+v86c1cHFhMLP3O3iAj4d8k1zw0l1+li7CBoo8XnRj+hgg
         T5eds0U7mHKRfHuRtBHLfDEvS/pPcmyX2+NQHX879/PhzQnqcI0pU2vuNFkcyZ3iDZIL
         TRH9PjLQC7PEKvaM6Hs++lMgq9rM8XKwpN2PaZdXoH8JKhiLerZBwn7lDLgpUNm6mr9i
         /EyuDdsLZFTPbEtaUDbdhir34njJDNX1BHLUKw/t89/gcHRvtHDNNadbPbKcRr3ca79D
         FdE/w7aYkA3QslqOCuflXMdSChsIizAYS2wvu6QMu/xmR91oDbbghpnfgeRRkNtzdn8j
         fDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830132; x=1760434932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbTmSFrTbV1O1JezcHCIzpAuTai20RptyHEWwW07HhA=;
        b=smcJddPhs92yKmC56//JmThKdJRiSj+svzDgFjuO5oaq0W4oStdSq2MeZkSBLtC2qS
         7ZZ58Ko/NKL9+AAzYcfpQh/si6gdcYVPIbrSVtkISoSWoH5n3ywL9xy6fhDfEu+dKr4A
         xkAH9hmNpbXF19awaI2NFR60R5E/RTA341Bc7D2VzHJFzWWHK994c3DxFdPW/CDm5qwr
         FJ22AAZ8j+9dSShUR00AdktpRvn9HbqXRxH3/a6LX0zkJKLPAOHhazHJPxSV0H2M0RXs
         IBUkREumn4c7JU+HfubZjhY2EIrAYtcbuAGavo5q4p6Ti2y5f4NvpvdOV2OzC3rkoXwD
         fJjg==
X-Forwarded-Encrypted: i=1; AJvYcCU+3FHzvk6PnIu7I2f0dew82PWXAtwm6Wou1fOfzaFMsDtsOv0hzp+V6/RJ+CRW3DEaxTuCssECBovMNkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFO9RfEZe6Vxms0OfqkaGAbmQPPNIkCWi6rxDm8OtglxAgbFCl
	KPZxHXzPuOWzd5A0doOTTmZWaKlwoI/l/YnwE49kIEoFbcQIfk2Y05/Z
X-Gm-Gg: ASbGncvjy/RYAmYmQTHxbhngCiaAP8Y8y30u8219cY2sHDDjlHcK4PVeoA7Ws6Yz9Ze
	JNWtVYSTgjqPVBYktdadvFeOhNBZylAnQ0Sd4WOB1dRiRWSpuA+TYvHQztHYGL3ktvgwHtXHfrP
	S+Fh0kMB1VybrIU5/SzUKSVlajXMkvdExv72JMnN7wfiWt92WCfMz28JPUdOS7Ked7FCr3GVnWl
	adYshhxu/OzI2e4NQb1wFlSDOYsgimZGwglEUqSP1sNQVtt5Pp7YOBt4sBFMVlFBhvIW11AF6Cu
	NHD96ibF/NaXkrCoDCgT372OkH5xJ59iIeF0qdhiiBoOOYyPNdawsveyK1Sbo7u0bXhwz3hMkxD
	ZfkNpOiBYbA+Reg==
X-Google-Smtp-Source: AGHT+IH90oRByw3mYhklQK0+LggQwiGhBDsXqhGzOt+l3haZ/I2j0XjdugbDK1RzQ+XS3wKV9EGIPQ==
X-Received: by 2002:a2e:9a0a:0:b0:373:ab06:1ab7 with SMTP id 38308e7fff4ca-374c382e880mr48480771fa.29.1759830131285;
        Tue, 07 Oct 2025 02:42:11 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39f8b8fsm8512171fa.14.2025.10.07.02.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:42:10 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 7 Oct 2025 11:42:09 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 09/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <aOTgcZWGlcx1TeDX@milan>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-10-urezki@gmail.com>
 <aOCejd0aghFS8iSO@MiWiFi-R3L-srv>
 <aOCqSrnazd2YwGbe@MiWiFi-R3L-srv>
 <aOOUlW0SbBcPM6Mq@milan>
 <aOPBePFxNk5FP/ru@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPBePFxNk5FP/ru@MiWiFi-R3L-srv>

On Mon, Oct 06, 2025 at 09:17:44PM +0800, Baoquan He wrote:
> On 10/06/25 at 12:06pm, Uladzislau Rezki wrote:
> > On Sat, Oct 04, 2025 at 01:02:02PM +0800, Baoquan He wrote:
> > > On 10/04/25 at 12:11pm, Baoquan He wrote:
> > > > On 10/01/25 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> > > > > __vmalloc() function now supports non-blocking flags such as
> > > > > GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.
> > > > > 
> > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > ---
> > > > >  mm/vmalloc.c | 21 +++++++++++----------
> > > > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index d7e7049e01f8..2b45cd4ce119 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -3881,19 +3881,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > > >   * @caller:		  caller's return address
> > > > >   *
> > > > >   * Allocate enough pages to cover @size from the page level
> > > > > - * allocator with @gfp_mask flags. Please note that the full set of gfp
> > > > > - * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> > > > > - * supported.
> > > > > - * Zone modifiers are not supported. From the reclaim modifiers
> > > > > - * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> > > > > - * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> > > > > - * __GFP_RETRY_MAYFAIL are not supported).
> > > > > + * allocator with @gfp_mask flags and map them into contiguous
> > > > > + * virtual range with protection @prot.
> > > > >   *
> > > > > - * __GFP_NOWARN can be used to suppress failures messages.
> > > > > + * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
> > > > > + * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
> > > > > + * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
> > > > > + * by __vmalloc().
> > > > > +
> > > > > + * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> > > > > + * and %__GFP_RETRY_MAYFAIL are not supported.
> > > > 
> > > > Do we need to update the documentation of __vmalloc_node_noprof()
> > > > accordingly? I see it has below description about "Retry modifiers"
> > > > where gfp_mask is passed down to __vmalloc_node_range_noprof() directly
> > > > but have different description. Not sure if I missed anything.
> > > > 
> > > > ===
> > > >  * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> > > >  * and %__GFP_RETRY_MAYFAIL are not supported.
> > > > ===
> > > 
> > > Sorry, I copied the wrong sentences. Below is copied from documentation
> > > of __vmalloc_node_noprof().
> > > ====
> > >  * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
> > >  * and __GFP_NOFAIL are not supported
> > > ====
> > > 
> > > 
> > > > 
> > > > >   *
> > > > > - * Map them into contiguous kernel virtual space, using a pagetable
> > > > > - * protection of @prot.
> > > > > + * %__GFP_NOWARN can be used to suppress failure messages.
> > > > >   *
> > > > > + * Can not be called from interrupt nor NMI contexts.
> > > > >   * Return: the address of the area or %NULL on failure
> > > > >   */
> > > > >  void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> > > > > -- 
> > > > > 2.47.3
> > > > > 
> > > > 
> > > 
> > We need. But i am not sure it should be fully copy-pasted from the
> > __vmalloc_node_range_noprof(). At least __GFP_NOFAIL is supported
> > and thus stating that it is not - is wrong.
> > 
> > It has to be fixed but not by this series because when __GFP_NOFAIL
> > support was introduced the doc. should have to be updated accordingly.
> 
> Maybe just remove the documentation for __vmalloc_node_noprof() since
> it's only a wrapper of __vmalloc_node_range_noprof()? Surely this should
> be done in another standalone patch later.
> 
Like below?

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9a63c91c6150..7ff81a38dcb8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4027,12 +4027,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
  * Allocate enough pages to cover @size from the page level allocator with
  * @gfp_mask flags.  Map them into contiguous kernel virtual space.
  *
- * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
- * and __GFP_NOFAIL are not supported
- *
- * Any use of gfp flags outside of GFP_KERNEL should be consulted
- * with mm people.
- *
+ * For detailed information about supported GFP flags and retry modifiers,
+ * see the __vmalloc_node_range_noprof() function description.
  * Return: pointer to the allocated memory or %NULL on error
  */
 void *__vmalloc_node_noprof(unsigned long size, unsigned long align,
<snip>

--
Uladzislau Rezki

