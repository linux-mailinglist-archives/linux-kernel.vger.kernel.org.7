Return-Path: <linux-kernel+bounces-884720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E56C30E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E32418C3DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74D2F0C71;
	Tue,  4 Nov 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfPVlvIU"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D32EC099
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257898; cv=none; b=A9bgjQFBkBOIsipcp41fzpQ/pnf1FQ7pFEkjCWOBw+VOfGiMRac4/654nnTUfk6FEGSGFKT82V2ctGmkHJ7Y6O28hZlNykkrzrQID7NiTQ8j7h04KIZkuM6mfY6yy+JQObSZRb5uop8G2lRmh+zBizVjPhHm9m5nE81BKWI/NY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257898; c=relaxed/simple;
	bh=91j83r0a/744GsjSSpvMj2vPPbbmwRCLqH0NKKKQxTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=K8/octdNImSsRwmFjvmz95LciYZnwqM5ztiviKvLT8YuSNjha1wtSiWZU/CsHb3PzDRIqg6qMIoPEIpjqQWC2deb8ba490X8Ealtrn6e2rmYkpPj+cgdvsEtxVEUg3x14989uxAe5oDiptxzFoDb6yPSlnPF8TZcFDRuS3rE+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfPVlvIU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26d0fbe238bso43118645ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257897; x=1762862697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIMOgpEtwvgPznTb3R/noQ8H3QESHZcJ3b2FNe/UuI0=;
        b=VfPVlvIUyTV8qIihY9JjSsKeyNBWMl6UMFmRHCYWXD/joLcLMadxUuigePc7OhaZrY
         poj39NwZlF7+axyTDmSBJZ4OAlWaIr7WNFIwvrpEi3HxnWPGVIBY+gLnWoFBRlDDThYl
         j5zBzjXV9t/sahOazDTvFdKATZUWOqVN1tY2AzxYG1MId0HMuxoSEe2F6b82KB1ne/h+
         LEDmMa4nPJ6uRvAYKezrrO6KUc7QMaqhzHqVkUS40HQUtiFYcPk+XmZH/a9FvXU2/hf4
         6a80ov5PHP2a0+LlvS8un7oaNXSNfvizKWZKs7QCnHqx/okdk249o3XS+QCDKsBfTnTM
         /yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257897; x=1762862697;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIMOgpEtwvgPznTb3R/noQ8H3QESHZcJ3b2FNe/UuI0=;
        b=ou+hd2nMWx1ZWc+fkXSdZNQ8eGO8AZsBLhVFGJhOzEBrsHGoFIhV5UWn7/Yzokav3l
         7yyImIkSQo1mgtLQ/DkInmqHuWyxbx5hoH0EOMPY3OipIHnfsXQEKtM+ZX2xVL1LzAMk
         1RlTw44470JOFtMJn6YvODLbAsu1jcFjuiXvIFaWiUs2HQ0To+U35PgkgaXCgOC1ZROI
         I1FuC8BspQolsxDEs9gfSBU6Dm1VijeCESRTcLZMEM5GhBNb2Y0v44nxYmu+af8O2mJr
         +NHaczMhTK5aLEnRaowrfQNeXXuMBbEuTdtKDiu57ZhSSksoanTT3aIK+xiwML8e5Uza
         ODwg==
X-Forwarded-Encrypted: i=1; AJvYcCXS7u9yO3BwBBIutFKChYR2ArKgx5lKG1Vh5116QIojBzK7Y92yqHbyrBrJzoDa5CA9CZDN6nhb3rAu1RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7c7qzi6CsTF86n58MbmnuCcb1k/SMGNnq32KXmXI8ORgyZPK
	OQv1EN9YF7yhUjy31TToR7Ca+STrhxB7w5bU1HivvDUQ4PqI3Xy61reG
X-Gm-Gg: ASbGnctJ1e6tKvdE4VGFaU5UFvmENok2X8Um7Mc7thJyCm+guOufSRJMaGAJmsHIBkL
	hZV8xz07EyXc7DvsYSRKASW8bIAa/nmfH25n2ajE1pOmaHEqaKMdIbwdmyfjwgiv9Qda/C/2+MW
	4KdVVx7sYAK/61E76CRaklYf6dxFkctj3qo5o+4iqaGn185m82NnH/y9lIeKdWbHubsv4PdVC+e
	jiXAg2bzqaiNSnUd8uAewMrPJjNuonfFkwLzkNfd/+X68mqJdlP5XmwWJXhHzAma5qlsrXXvI14
	C7pVlsHG0LeSIHSY7Bsx0dBmOX1yyjF8YNl0QfRWl4DGQ7LZrXuV7IUnPO3tu+4SqENsSkohvQn
	H96IxYcjrfUjKMeo++VfOzyBULwrFMm8s7otVYzCmK1uIbB5hXMBjXpYiEAIW26WvsDGUJjcVf2
	BdxTj4Ic6bKUVllRlmSoFN73E9DuhZCLn8SmtgHep+27qdfU2aZ6iWkw==
X-Google-Smtp-Source: AGHT+IHhptMGeN6GUWdSr3woSCYhxUw05Wn9RRD4O2T5DayZS0jhPNbaRMV4ZHTfd4sd7Ew85mCkaw==
X-Received: by 2002:a17:902:e88e:b0:295:fe33:18bb with SMTP id d9443c01a7336-295fe331993mr38565105ad.14.1762257896410;
        Tue, 04 Nov 2025 04:04:56 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.200.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2960199831esm24707045ad.37.2025.11.04.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:04:55 -0800 (PST)
Message-ID: <a05cde7d15d85f2cee6eafdb69b1380c8b704207.camel@gmail.com>
Subject: Re: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in
 generic_write_sync
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org,  linux-block@vger.kernel.org
Date: Tue, 04 Nov 2025 17:34:50 +0530
In-Reply-To: <20251029163708.GC26985@lst.de>
References: <20251029071537.1127397-1-hch@lst.de>
	 <20251029071537.1127397-3-hch@lst.de>
	 <20251029160101.GE3356773@frogsfrogsfrogs> <20251029163708.GC26985@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-10-29 at 17:37 +0100, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 09:01:01AM -0700, Darrick J. Wong wrote:
> > Hum.  So we kick writeback but don't wait for any of it to start, and
> > immediately sample wberr.  Does that mean that in the "bdev died" case,
> > the newly initiated writeback will have failed so quickly that
> > file_check_and_advance_wb_err will see that?
> 
> Yes, this is primarily about catching errors in the submission path
> before it reaches the device, which are returned synchronously.
So, what you are saying is file_check_and_advance_wb_err() will wait/block till the write back
request done in filemap_fdatawrite_range_kick() is completely submitted and there are no more
chances of write back failure?
--NR
> 
> > Or are we only reflecting
> > past write failures back to userspace on the *second* write after the
> > device dies?
> > 
> > It would be helpful to know which fstests break, btw.
> 
> generic/252 generic/329 xfs/237
> 


