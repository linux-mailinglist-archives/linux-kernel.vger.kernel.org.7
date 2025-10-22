Return-Path: <linux-kernel+bounces-864344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F62BFA8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA9D3A1F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B7A2F7AD5;
	Wed, 22 Oct 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+zWDAjQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96272F7AA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118235; cv=none; b=cohguxQoq7c/odfIdCBf1IRbgZZqNIiGa6CfmrcuuLD+ur0floKaecueXCY0FB1zi2/FvO5XadUSKQ2l9CGw+uz/n0RwVQ6zTh7mCFBCPxbgv6Ae6grEX+d0EDTQhZmB6MUKK1aWB3AoeOvrfFM7lB9vCTkuhfNXC5f3IEv6VHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118235; c=relaxed/simple;
	bh=2WbxbiuiI1YmzcCezUkZMvZunMrUw0Ujj5XMOAzkydM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/FfL0dkramzje00k/QoNzxklFZXND02GUizyK5lFPBPcmuz2WtrUCvyBR5skjTeZAgL/kEWoDwxR18uyjkpZiiuHK4GUCE55YjCvg6Z236IicS7GlT+437uFX0tMEk4+VXZgZg2ERmVvMIAI/dzaOJVCbA7l+U8diadHNitAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R+zWDAjQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1rU8H/rU2g3WfGccOFtwT7WjZ5YfIx7nNgO5laRekGY=; b=R+zWDAjQmwTyBeuhOgfXpahr/2
	T+hX/ihzgevVD4mAgneBxY0Xt8+m1T8VuevXkZ8i69rC6iJOVrC6zikDo3sVRgBeQquONenO+MK2B
	T9P4mW/Nt8rXPgLskX03A/Vn3av98WMtwU6KacXUQpnVkArbdl2cM5koJkAn0wELyGopsKU6kv3v2
	Ax+C+3RP+7I/HEgGYnBA2QfvrDw2lI4mBmxu7NUjnGewx5X/qZuxZF7XaUYdhfbBRl+YooYItklrl
	40IXXkbic4WWf9NkPSqzTQFReyZECY+qj+mB7bCQpxHtEwHGE6kzcnvrXxUj9pvHNAcmIhLlnHn/a
	qeofUawg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBTIm-00000001tJW-0QvD;
	Wed, 22 Oct 2025 07:30:32 +0000
Date: Wed, 22 Oct 2025 00:30:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: xion.wang@mediatek.com
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	wsd_upstream@mediatek.com, huadian.liu@mediatek.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/1] selinux: export current_sid API for use in other
 kernel modules
Message-ID: <aPiIGG1Zw5hJ2O3k@infradead.org>
References: <20251022072729.14820-1-xion.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022072729.14820-1-xion.wang@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 03:27:17PM +0800, xion.wang@mediatek.com wrote:
> From: Xion Wang <xion.wang@mediatek.com>
> 
> We have a kernel driver designed to monitor the status of the Android
> userspace watchdog.

That module is not included in the patch series, making the export
directly unacceptable.


