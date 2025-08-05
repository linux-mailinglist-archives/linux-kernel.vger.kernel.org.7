Return-Path: <linux-kernel+bounces-756929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D400B1BB22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0AA1881C61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6F22D7B9;
	Tue,  5 Aug 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vvblv/Nk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F01547CC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423068; cv=none; b=BLK65fU2dvLJxCHTHwPCDOVQchzFLvmOQsh8hxUPKek/FTDh5QCrPMP6G2Mu8uqUMvzdSaxikdWFhVvnronsN96RwVI7eYohVaelAhZmm3kHxR98fU2CthcaJa5J6tKzcVTwwQ0U6p+wSKlEox28RkvlHNYgHuuvkivF2dTHsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423068; c=relaxed/simple;
	bh=SfBzt2N3LNeDAm5Tym0MNtM5fNHtmIUlijMC48PoPDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THSEqr3UyE1EjkadhK6TzhkHTdPtzPn7lmKIIBCL2muQ6nxLBs0+lnzqpKkFRkqPYJBpOy/sTqEHMoqCFJOjz1rDq9DqyZsZuvf2lE6HuZrVHSGarODjE1kj0a1nbzkFeWAoT9Ci+a+NYkPwtW2g+ITPY5VXDZYwS3dUIatj/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vvblv/Nk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754423064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfBzt2N3LNeDAm5Tym0MNtM5fNHtmIUlijMC48PoPDo=;
	b=Vvblv/NkvReR5g4zV8PEELZtvOlL02nukBLoP/Ikv0WknjAsXfrnnZGZk5eRWTX1e2M4Et
	MbgahLL0/tRb2twNbs8pFsxhzG1QS4iBnVMdkg/UDsUggMviPeCgGqchAvcqqM8scySCH2
	4RfQbp/0jDF52TctS8b42kixtTtO+zM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-3IhIyEopPyiYOwFN8HuviA-1; Tue,
 05 Aug 2025 15:44:20 -0400
X-MC-Unique: 3IhIyEopPyiYOwFN8HuviA-1
X-Mimecast-MFC-AGG-ID: 3IhIyEopPyiYOwFN8HuviA_1754423058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F481800370;
	Tue,  5 Aug 2025 19:44:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B8E1D1955E88;
	Tue,  5 Aug 2025 19:44:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  5 Aug 2025 21:43:07 +0200 (CEST)
Date: Tue, 5 Aug 2025 21:43:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Xiang Gao <gxxa03070307@gmail.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYQ==?= =?utf-8?Q?l?= Mail]Re:
 [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250805194302.GC27131@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
 <20250804114900.GA6656@redhat.com>
 <20250804-gepfercht-delfin-0172b1ee9556@brauner>
 <aa5272ddcec944e2a35ca7104f6a86bf@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa5272ddcec944e2a35ca7104f6a86bf@xiaomi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/05, 高翔 wrote:
>
> I also think "WARN ON ONCE" is quite sensible .

I am starting to agree, but lets wait for Christian.

Oleg.


