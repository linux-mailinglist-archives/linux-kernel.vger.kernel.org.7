Return-Path: <linux-kernel+bounces-865773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E88BFDF83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5F834EE080
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EC35B14C;
	Wed, 22 Oct 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPzg+thY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8234DB41
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160079; cv=none; b=bIVxNwN7ytpgpWCpUrIGNqcm8Y3nkCtktC+8H6HOyT6vANc1IC6tlzUqIREkV0rvxBXN7Xk7JhpdBKMDwfOleO+Pwh7QhIqXvB3DXn/wkFYjBSFREzILve1PU8y+FL6bsPcIFxTSobWhzvEaMf+6RyVZApnMvm+FDltbOdqZdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160079; c=relaxed/simple;
	bh=18zbZNBSnfzEQNxf3NzURV1iOgz5TdTGposrZRBN7p8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mXOLJoIIBWHiFzNMRShovChnF5sjOEQoVyIpyvHi/A90cXY3VgzhZeHK+qPSe2+mdZV0/Um6BPnqw6KoTjgckIiBt4EnKYpNxc+9hSr8u+C0A76N1AaNGumVn9KdvJtDwPhxpz/2MxqXruBe1zN9x2Ae/tGhYjh/iPJTxRe75jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPzg+thY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761160076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18zbZNBSnfzEQNxf3NzURV1iOgz5TdTGposrZRBN7p8=;
	b=CPzg+thYi7p29n7K758LgwHMp9XAKo21iVVkzAua3dfeEnfFpVWO9BaI1VFGo32l5XdsNF
	CDx4VAiWUw6kEyknJ4k5Q6FzQV3axtvTWdKlFCaGCCcCddziC7WrQCbpizE+qDkLDQdiyg
	fCeIEZ8qPc7CAt61J2Ri3vtr/VbJHGI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-oZlGmZ9NMNCnjhH_uti7fQ-1; Wed,
 22 Oct 2025 15:07:51 -0400
X-MC-Unique: oZlGmZ9NMNCnjhH_uti7fQ-1
X-Mimecast-MFC-AGG-ID: oZlGmZ9NMNCnjhH_uti7fQ_1761160070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3ABD1800657;
	Wed, 22 Oct 2025 19:07:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F0151955F22;
	Wed, 22 Oct 2025 19:07:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1784747.1761158912@warthog.procyon.org.uk>
References: <1784747.1761158912@warthog.procyon.org.uk>
To: Markus Suvanto <markus.suvanto@gmail.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix dynamic lookup to fail on cell lookup failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1785738.1761160065.1@warthog.procyon.org.uk>
Date: Wed, 22 Oct 2025 20:07:46 +0100
Message-ID: <1785739.1761160066@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")


