Return-Path: <linux-kernel+bounces-845882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3CBC6673
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C7714EDF3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE0B2C11ED;
	Wed,  8 Oct 2025 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyBGQQDP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6721E834B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950165; cv=none; b=HE0QP34pRCmn8gHGsqH7PdbGx6LO9T7qUHHJd+K864OPmN5eOHQDKKdu+8bC+lDktHI6W/KAyqSplUxPJbx677X8ScM29VFFGRVa3GCFT4V+n8cuxdCdfLc6swfOzbfc3Y1gRbipBBcbgn1T0p0R6w/3Ki4GsPp/lsgen/SdR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950165; c=relaxed/simple;
	bh=x6Cx+2/65U4Z4aV1uw4U7kRIfruYof5JPA52WE6aH1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f94QYG8kuw2EpW+YQ0a41eLhfGn1LspZY6tubeaQhvr1xiNI1VgLiaAlIB80ugdI+Ch+BRsuKvTzHqDQk0QDYdQVaMIBVim12OBbcdRhOWd9l9MoCMKM3J6VWiLsRD0CJ0h6rc9yU58DVl8UQfKFQKgexw/QerJjSKqgRTe1XYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyBGQQDP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759950162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHoLIPpvkEXMktd+Uj29/fm80mbfI/FGCSM/Gp/0uUI=;
	b=QyBGQQDPQD4X50114mvOmrDIMv2dv9LpO9ch+YQY7oGYtqMpQU20JV5plQBSTEeyaD9sFM
	ilq2KLLqHPd3TEEmFNPPHkNoMi48l1ypT1K+2eb4fz+CHIK+/OKvp9Dza02ve+7ZT3KGsV
	mvdnI+muqaT52lo++SLuuQVvWq+b6r0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-Gxd4Ntv8MXCnnUEwyPCYCw-1; Wed,
 08 Oct 2025 15:02:37 -0400
X-MC-Unique: Gxd4Ntv8MXCnnUEwyPCYCw-1
X-Mimecast-MFC-AGG-ID: Gxd4Ntv8MXCnnUEwyPCYCw_1759950155
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 624D8180057A;
	Wed,  8 Oct 2025 19:02:35 +0000 (UTC)
Received: from [172.16.1.51] (unknown [10.22.89.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A4BA1800452;
	Wed,  8 Oct 2025 19:02:34 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH] NFS4: Apply delay_retrans to async operations
Date: Wed, 08 Oct 2025 15:02:32 -0400
Message-ID: <ECC2D7B9-3D90-408F-AC4E-2E663E1FED3C@redhat.com>
In-Reply-To: <20251007212452.599683-1-JPEWhacker@gmail.com>
References: <20251007212452.599683-1-JPEWhacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 7 Oct 2025, at 17:22, Joshua Watt wrote:

> From: Joshua Watt <jpewhacker@gmail.com>
>
> The setting of delay_retrans is applied to synchronous RPC operations
> because the retransmit count is stored in same struct nfs4_exception
> that is passed each time an error is checked. However, for asynchronous
> operations (READ, WRITE, LOCKU, CLOSE, DELEGRETURN), a new struct
> nfs4_exception is made on the stack each time the task callback is
> invoked. This means that the retransmit count is always zero and thus
> delay_retrans never takes effect.
>
> Apply delay_retrans to these operations by tracking and updating their
> retransmit count.

Looks correct.  I wish we didn't have to assign these values back and forth,
but I don't see a better way to fix this.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


