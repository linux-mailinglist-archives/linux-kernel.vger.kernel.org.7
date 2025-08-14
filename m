Return-Path: <linux-kernel+bounces-769077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD26AB269E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A625E7A56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FF1F17E8;
	Thu, 14 Aug 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KQNJjeAf"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993721E0DFE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182233; cv=none; b=HrHGlZImIdyC1x5IV3fzsbgLvDqvpk2vq6OiMWfXaYw952bfORXny3bjGPtUqELpYx6M6Ovuhq+B58FJ16Pen5kV3RZDzZuF3LsXkJtzDvU48Sr2fyhtyLq6Aopnv0dXdZk33HCJzvAIoNVyVrcO6hVwcsUBh30+Cv5Gqkx5MN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182233; c=relaxed/simple;
	bh=NOpPaMEGwARq4CHAFNBf771d9jPnS5ZeE6rfKhlvASU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2Ykeo10mNwrmh/+gQIPLI0pDWgpj6o7QNQwBunwnae1QCfR5KGZZKYGCIa7mx3eSeovkg2HHjcIRn3HNZBChKXBW7azlmp4mcBqInbWzd9rCSk2aCfS4ijyS+M/gmZy8+zeo8Xt1pCsehT8hX9R5695kjfax4tfrjsOR2LHnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KQNJjeAf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109c6532fso9227131cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755182230; x=1755787030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thFJCyGfhvQRRqY0DjMQa3Qo17IKtZ1G40gUR9k6ews=;
        b=KQNJjeAfSoSwUDRw80154oLg3NjJYeTUwz6KXDBkYfQTu8vynYQjQRzggbRtxTurRv
         L1oI7K7IHGucMXWSh43/r5zPlnon/WpknKv47HhPAwiY1H/gITEGb+I8a/WvoKgR8SpP
         qeUdiB/FilITBvEDt1dY4jA5A58cLYBl/doa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182230; x=1755787030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thFJCyGfhvQRRqY0DjMQa3Qo17IKtZ1G40gUR9k6ews=;
        b=rPOOWxj5ldPyGfbrEraaCYcxgWVA4wOXgz6MR3gop1GpvqpDOCxvwlrQJEx4i2WtLA
         hyANc2Gctl1tdS87TforYGn4jSTRn1bSQcXxBVQEmkCqs0DG7UTj+WnjHVUhqm614oJN
         l1UlFKMyFMxRRZj4QXCEvVgT8TDycxqoKu7ntTAciTkwKm2Pc8db55ge+C2+5ZqvwCl2
         7B04d5bs8plgu4dPcahUaPbsguKvYEJrjPDTWtPn7M0NU56WNHrOsNeSaShwmN+m5z/s
         R0TIIpATFc2Gr7wL0D2ENNXUbtfmEMheCC0gHn498zfx60lCxrG+313uuMa0OQWCVxtY
         1KfA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+w2fiT228JypDFOPFXeube0n++WUujLRl5LU/Dgck7U/rMdSWh5Llvyw6OdxBgR87hkP5CQvUPNfLas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5qU8mS1qYOL4nfZNGPme+2IuNlrZsRCXcln0FLlY69frQlFG
	qSEuL8JrvUQNfTiWOA30X/0DYaqMKeiCYAnaUTkL52NxVrMd5UKg9FbV8L4K24nwIvmZlFxeb9G
	BOvzhdYf+QIO7npuZiUm90X/8yS0vgdUuaroimtyTsA==
X-Gm-Gg: ASbGncus/D7CNPXq3EBgJEczIjcdAoemq2TdyGz8FK7lKZuY4PrF87t07b0D2oOfLo1
	6btj480p543sN4z7uU9wIL4U55iQqJlWu3vNQ6NmSOp2/Xr8XVkh3vzZLFiL+y96NSHJSN+Qvq2
	u9t2mjEwWmkGRA0jusZzG3ze1rkO6hTZTa+vva8qqgLZG83tbNfJjgj0F+lXrNTQLy+p5sTrhUW
	Aja
X-Google-Smtp-Source: AGHT+IHnfRI5xHzwEiwbnlj4w/zFMDDNEEaatcq1mpqAAB2GV7mMF1beVsw/Q/x3FPL39V74ikfbsx8wh3qug5aBccg=
X-Received: by 2002:a05:622a:1926:b0:4af:15e5:e84 with SMTP id
 d75a77b69052e-4b10aae7b12mr50528031cf.42.1755182230192; Thu, 14 Aug 2025
 07:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
In-Reply-To: <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 16:36:57 +0200
X-Gm-Features: Ac12FXxrfsSu-05pCnMumsCzYXADqTJ2OFTZfF8uQPidyp6kmWUcoLNSx-lr5VI
Message-ID: <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 15:36, Miklos Szeredi <miklos@szeredi.hu> wrote:

> I'm still hoping some common ground would benefit both interfaces.
> Just not sure what it should be.

Something very high level:

 - allow several map formats: say a plain one with a list of extents
and a famfs one
 - allow several types of backing files: say regular and dax dev
 - querying maps has a common protocol, format of maps is opaque to this
 - maps are cached by a common facility
 - each type of mapping has a decoder module
 - each type of backing file has a module for handling I/O

Does this make sense?

This doesn't have to be implemented in one go, but for example
GET_FMAP could be renamed to GET_READ_MAP with an added offset and
size parameter.  For famfs the offset/size would be set to zero/inf.
I'd be content with that for now.

Thanks,
Miklos

>
> Thanks,
> Miklos

