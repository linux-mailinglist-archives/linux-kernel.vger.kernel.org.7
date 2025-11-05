Return-Path: <linux-kernel+bounces-886917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5EBC36BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86C4C4FEAC4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C1430EF7C;
	Wed,  5 Nov 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Hrl2iA8G"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3737303A32
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359923; cv=pass; b=Wr3QFdKSZanAaGhUwDMWlgFR42tJPTZ16Ubk8h6GCQRcsCxALAn9WVGEi2f3JpADmUPR8RKsq0m6frPz1CKMA02yEi0iAFR/kxXvPViFRyGFxMJZRGBi4bUwCLnmYg3dgR/oRgN950/pV0N+Oe2k/KCRq/3XsmvZQV2QDtvCMaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359923; c=relaxed/simple;
	bh=Rl19m638bZD5+nDRS4EjgpvkcK4WNXehuuvbZXq6brE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy1DG3Dq/VrY4LVjHnoxaIlQxhRVokJYJlfHN32c6uW3dtACp+G5im8oTrLSAFysN9as2hOo8QhDEJIBdXGdMC9HZCuxPDKAqTk99fmLLfpiTXFNf/hNs62dG7lX19cdyX5ZXxjVQ+cZQ4W+YEyJuC1HBROheZBVmlDXIjIW51E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Hrl2iA8G; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (91-158-51-183.elisa-laajakaista.fi [91.158.51.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d1rJm0Dr0zyV3;
	Wed,  5 Nov 2025 18:25:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762359912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbrNsaODE6kiP4/2mZ3jigbEmzpRZ8j7JVlsy+3QFZ8=;
	b=Hrl2iA8GXReDCNtxe9y2SGHH92DjHMMxIDkrgrM4tZEhag0VOPbm+3YrlwhQ0uUKQSMzRU
	e/ATTVDo4UYhnip2erkNl3OLv5pGWXzRkm/qHzmk+2tVHzzWJ5MT3vC90tb5twAX/fYNqf
	XLTmKTNVDUZyPWvyZEBDKcQT+A4aG6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762359912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbrNsaODE6kiP4/2mZ3jigbEmzpRZ8j7JVlsy+3QFZ8=;
	b=OCgFdhIQDtppRXsa2I5ABAIIz942YRfF8dJIAQLN+LdecIKOPneYJANfTQk5jab3IuOTRg
	oMF4DpVNPqYPPVNRm07SXSHCDCX1uwGH8W1il9qWAjkU2R3fx8PPQArirfL6R45Wef+rC0
	ksQ6HWR3noj1IpbGk0kK7qmCbDMNO84=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762359912; a=rsa-sha256; cv=none;
	b=jRgsrB0f5sJAeN9n8U0FZcgjdRZj3NpOmKo845lIvJVDL7Lxc6G7D+9mEjgvQbxzMIt6Si
	JEahaR7armD54tewV0ylntncVYxpyC9AADPnLs5W01WRvBZErngLGkUlEbl76xAtiA31I7
	WIpVRBXbo0mx6pIjgqhS6hZbYaEO0OY=
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 5F483634C50;
	Wed, 05 Nov 2025 18:25:11 +0200 (EET)
Date: Wed, 5 Nov 2025 18:25:11 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joe Perches <joe@perches.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] checkpatch: Deprecate container_of() in favour of
 container_of_const()
Message-ID: <aQt6Z0gmNz-lCrLg@valkosipuli.retiisi.eu>
References: <20250811085731.2117377-1-sakari.ailus@linux.intel.com>
 <aQsF9tuTWRn3tfS_@valkosipuli.retiisi.eu>
 <aQtKul7TSt-UVsIl@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtKul7TSt-UVsIl@infradead.org>

Hi Christoph,

On Wed, Nov 05, 2025 at 05:01:46AM -0800, Christoph Hellwig wrote:
> Well, if container_of_const is a drop-in replacement for all uses of
> container_of, just fix the implementation?  If it is an almost but not
> complete replacement, find a different name for the few uses.  And if
> it's not anywhere near drop in, just using container_of make a lot more
> sense.
> 
> Just in case it wasn't clear:  We really should keep the shorter nice
> name as the default if at all possible.  Both because it reads better
> and because it avoids churn.

I'm in favour of the container_of() name instead of container_of_const(),
but there are a vast number of uses of container_of() in the kernel and
fixing these to respect const qualifier is going to take time. The intent
here is to prevent adding new uses of container_of() that do not respect
constness.

I tested this again on v6.18-rc2 and with my .config (far from
allyesconfig) there were 840 warnings from discarding const qualifier.
Presumably a lot of these are duplicates, but then again it'll be a
thankless (and possibly endless?) task to fix these if we don't make effort
to avoid new ones from being added at the same time.

-- 
Kind regards,

Sakari Ailus

