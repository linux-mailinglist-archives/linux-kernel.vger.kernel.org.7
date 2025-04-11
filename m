Return-Path: <linux-kernel+bounces-600417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABDA85FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FE116C80D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387C1F1931;
	Fri, 11 Apr 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Buc3s8mA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783F1953A1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379319; cv=none; b=qLFbHAaCCiwMGrcg2/hZlwEZhDgd0Vpjd6AhuddlBSpN5VA4qTue4ZIBC92k+b7eupKfkTc11g/FKwTjEAVlwC7nTo3aHjLAfzkHLpTTNHC77GTACLSpP2m+iA6n07O9IEqH1q04eYrluyQ7UOK4yIo8U8VMmP+tzyb/7sZcDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379319; c=relaxed/simple;
	bh=FppYHN/qu2n9iiq/ee/to1M0y8WJPMP+sy5NMHu2ZbA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=nn8HvUKujmNvI6PanytzOGjeuuw/mcSR/fiH0kr+IPaszvKTCiaIyaVe9JCSG5wzi/Wj2wKW5/lgNWOCF/qfhii8ZeO7X6FFG3TfSjZ+bNSz77jNWdzj9InTaX2g/3AmmwbEPyP6opoT3OUzgxD3XcDlC1yyMBFs3xbtWlrS/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Buc3s8mA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744379316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziVNbANRmyi0790QzmsXdsF0qsho9qMRA3TbDUmAaDs=;
	b=Buc3s8mAmhVLSFE0SruRzfFAAPfGXiQXiKuIGr4Og90sY/7USuWEqIkw5SJhO6jR2dP/0X
	lchwUwwmpDXN3vGAUeTR9gOPtq+3mndSYNyUZ8+qBMpwgQeX1o2tDm9/fXE263MWk/4sEE
	OEmS2Zj+SFTgR5oAAlKTSo5fDYRsJ34=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-NhptXqgLMby4Ox9QW00kSA-1; Fri,
 11 Apr 2025 09:48:33 -0400
X-MC-Unique: NhptXqgLMby4Ox9QW00kSA-1
X-Mimecast-MFC-AGG-ID: NhptXqgLMby4Ox9QW00kSA_1744379312
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 836321956087;
	Fri, 11 Apr 2025 13:48:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0297619560AD;
	Fri, 11 Apr 2025 13:48:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <f2b15e2f951e249e98f33b07ee261b9898dd41d3.camel@ibm.com>
References: <f2b15e2f951e249e98f33b07ee261b9898dd41d3.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-7-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 06/35] rbd: Use ceph_databuf for rbd_obj_read_sync()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2370586.1744379306.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Apr 2025 14:48:26 +0100
Message-ID: <2370587.1744379306@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > +	dbuf =3D ceph_databuf_req_alloc(1, sizeof(*ondisk), GFP_KERNEL);
> =

> I am slightly worried about such using of ondisk variable. We have garba=
ge as a
> value of ondisk pointer on this step yet. And pointer dereferencing coul=
d look
> confusing here. Also, potentially, compiler and static analysis tools co=
uld
> complain. I don't see a problem here but anyway I am feeling worried. :)

It's a sizeof() construction.  We do this all the time:

	struct fred *p;

	p =3D kmalloc(sizeof(*p), GFP_KERNEL);

David


