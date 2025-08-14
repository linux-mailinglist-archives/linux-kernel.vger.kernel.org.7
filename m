Return-Path: <linux-kernel+bounces-769448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D2B26ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589B67B8C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9AF22576E;
	Thu, 14 Aug 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ko1yaJ1J"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B22319867
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195937; cv=none; b=nwFO68gUS/RR2N/TB6c8bhzYF652RT1JG5Zd92PwKmlccrBBS981+PnMFn/my6yYhb1N967y6fVhmEkswBQqB6jmj1zMdXYSkXJm8qzjXwVS0s1F7mTULW3RHFL345bIeNWRYmy2Uc217mff3vd/EfSy3YfHgGb3s4vVqpQrEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195937; c=relaxed/simple;
	bh=QlxV/Fo/vL6WCJNsSwAfnDwsEr9HvLtREXvO8jaWoVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLDsRkObHHDVcwTQuLD8fu74lhl2NgcajIVdEu5grVaaJxL4mPRgAnwoIfRuh1XfWm1Ad2OQ9ydf3aMossUCwHRYffDm7uapeqGmzY1W3rsw7BaR+zz7g5njLzNGER1ozmQ5+15BGRqJ6POXafDz9wl7DWkiD+eIHrYH10QVdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ko1yaJ1J; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b113500aebso5337641cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755195935; x=1755800735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaG/9Mc3gO9Z05dXGGeK8opCDGdDbOMVGSG4B2PlDgg=;
        b=ko1yaJ1JMyXmfvMTXB7j9EYtUf4g8Ob8wi0QKyQLB6zSJwBFHgye+nIkfRwA5sHaD5
         vFMD4P+YScuUtz6XGI0kSMNDuvJfzyaRVD3QKounFxB18buI4bsRMakeb383C6CynIQc
         nZdVeIxc3MWo+z0MtXrcucnhvg7NMO7KTR1f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195935; x=1755800735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaG/9Mc3gO9Z05dXGGeK8opCDGdDbOMVGSG4B2PlDgg=;
        b=wSsUvam46OFxG8b8Gd7OOUcktDvd5MvGFm2vIzR352OXwqAIl2aa11UKo4kufK1b97
         4BtJMum99DvwL8WG7YzYGkmKqgQmo12hocCirKCjjSMCIcBJkNOiQNOWnkw7PJgEo/yz
         x66z1ppr2K3/oQV0IToyHpu329pLhlr2ftp6gqmWPfGM+3wV37x3cXfHQ9TVc6tkArFX
         RwL8K3lz58izoPWcQvkzzT2fbR67Hj24KasBRGHOTpBeYbYCC3T0BvGeDHKkvWS50Mu5
         3/CA8SOfMNX+l2xMCGKSHqXIMcVdBwRqxECSBnni/PGV4fLS0hgt/oFsCGDtbFAL6YFf
         EVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+brzl9r8C6pBtLo6R7kpLeZBdO7OK/YeqrL0jIVc+2N96Md77USNiIduWzPDdMNgQmTdUoVJ58eHDYjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHYvM8th4cCDjRAlJwq0eRxxG8iN4s82+zjqOKqNT48RFV2aO
	7I7YHj0kmoeq+adi2ss1y8xDT5TCI/Hv5UI/YIxltx9REkEMMzCswbR5rFy/26c06yEEYpdinvD
	AANVoSq7Nl+JY+Og371rTmkJLOfJUVkwyIBMgajceDQ==
X-Gm-Gg: ASbGnct6dt6x1ChGCz7iL3Cdxn2V1XY12QlwQf1yc5IPtMx6yDhL4qX5/Zm3EycZXoD
	4Is3ZahW7skxTHyFtzoek7+N7ZA0zVgaFmkbMfirXtExiOt/Ehy51SxgjaU/tCV9ajOjQa/5csL
	0MYtNc72zGXMMmCw4m3requ03Rvhwv3qj5rlNwmmusbPolQ7Iy//cUU04xx88SL3q1GDvu196ky
	4gW
X-Google-Smtp-Source: AGHT+IGSn0lQHqZ9RP9BbaqY15avh0lMZ+NAOhYoifmbXNq37t8nR6rR8emWPkr9ymaCKi05XQKiq/L5hGeuPEvoQWk=
X-Received: by 2002:a05:622a:2c3:b0:4af:21f6:2523 with SMTP id
 d75a77b69052e-4b119812238mr5676291cf.6.1755195934739; Thu, 14 Aug 2025
 11:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com> <20250814171941.GU7942@frogsfrogsfrogs>
In-Reply-To: <20250814171941.GU7942@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 20:25:23 +0200
X-Gm-Features: Ac12FXxTdDrnRb7Tf9wOWEPTOrq-mapbwGaLhT9s1IZLVbyqxOHLM2quCQmv3sc
Message-ID: <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 19:19, Darrick J. Wong <djwong@kernel.org> wrote:
> What happens if you want to have a fuse server that hosts both famfs
> files /and/ backing files?  That'd be pretty crazy to mix both paths in
> one filesystem, but it's in theory possible, particularly if the famfs
> server wanted to export a pseudofile where everyone could find that
> shadow file?

Either FUSE_DEV_IOC_BACKING_OPEN detects what kind of object it has
been handed, or we add a flag that explicitly says this is a dax dev
or a block dev or a regular file.  I'd prefer the latter.

Thanks,
Miklos

