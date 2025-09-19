Return-Path: <linux-kernel+bounces-823792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC8B87725
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EB27C5DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABD1A3178;
	Fri, 19 Sep 2025 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLbHb9Qt"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF982286A9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240199; cv=none; b=EfDsxFhwGTUMLpmExRzxTKGk3Av/96G5vC8TU5IcaCRYJ82ijmqaPvnJmfCt1ymIELN3q3VMcNd5PwzOcD0NluqySUR9jpsPrqThAhy7vOA/JbLKQ6p72hIe7W6tBLbTY0jaKDEkTpAuL180/vw4xbpT99pj5Kz9LL+OozuwIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240199; c=relaxed/simple;
	bh=UbPsriC3QrbOJZ1ayqcmZNmKEipc4ibxvlJqaquyJfk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRpVmzDkhoSiF2tE+7W8NGr7hxw255wb+k/W98sMrhInStTSkFp2JqmCcO0aduqmuBuvfTuhY1O86NGdXxB2ZdyJ/Lm92DjG/+zr1Z1JJxW1aMskmD+zLgS2yTnFUff784L/luF0rC8TNsiz8x2e6UVEdVw0JVoY1W24AmMJt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLbHb9Qt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso1099625a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758240197; x=1758844997; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hI40T119u35xMB16MFk6zQZpzcNd2m9zwdEQjzTmVk=;
        b=FLbHb9QtowEo82GmDINgWU+Hol1liI5jQZWoPoPtA5PZRfcqzxk9ay3wiF/k7exZQd
         XEy0GZ3KAEshfBmXnDUv1cias8p9HTZhCHYawKEeLlg5+DFPNqJ6//wwblSkj5PANDza
         LuScuMk7Pjt6YNNOzhHW2DqDkb8/9Vm3+bvHSMMgmIY8e+weaobaaa/0V0z7meAozQmd
         ZXzh6afWlKOuPykcgVzEz4buARqsnWKkPz0HzzelIMJQwR3/Juh8l6BzJxLd1XpBcTfl
         luVvPffy8ZHoxdKBH2iT/bl36NsP6wbd+qkp4CB2xbpbo9gzpUhySU56Xyyxn8t1Pn8u
         LUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758240197; x=1758844997;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hI40T119u35xMB16MFk6zQZpzcNd2m9zwdEQjzTmVk=;
        b=PIa1hCy6Hyk0alMS+EvVjzivhtp1rfanTdEedVtrgsD+qP/NdkuWhMaLL1jtfAhL5+
         iw0W9NcyMhzwjtBweVXerr4T62sfsMG3AIyCw3qNsgT/W1PIMxso6LquFVTAlOOrml3p
         bZFohtjfHgqI86PBCYfC7YfCT7eJr0bDcua8rO2vUC/sRbDcoqJSgvfaFziH/IbEyT9i
         E8YaleefSnx4vEG8EvcqkuPfDpzD3hz5ePGipQlj6/RK278McB55FATCTBLx+aI2pvOr
         dtBP8dGQLzI3HHZVdiODsHOfssW2RqP+wjScQi1JmdWp9URNu/pyfWt0Cj41aemj3KCj
         801g==
X-Forwarded-Encrypted: i=1; AJvYcCVlTnOYzjQqvUvH8EyJjRaxJz+VU7QpE/ASGBd/8Ge0X9RJzpM9RTyWG0ctzpQkVGE6tpBu6TpM1ZT6JYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhuzGLofPMePY7hWW3L3e7yV95Idb8F/Ze1Z6wpzRFXKKLV8o
	vvXyTmj1pjmjmeO9DBKz+QqPcu6qqDF3iNao/k62C3OZI0jU3Yc7aeiY
X-Gm-Gg: ASbGncvPPHGiKMV69hx+xFWWWku1ixRL8iraKR4gDxxRXjid6QrCB5j9/gwxkC5/QFR
	bAVEBgL933GfdcxZ2j7Wh50vVzHUh6LTjipS04jzUmt+PbtV9pw+lAdR1pbA2OupiHxUZB91C60
	oZxwW0dDR36riH8ZkDkxNw8fec52+Vy5U+sgAtGznSlnPBZcSxlOxy1MR69ZtJk7gEOpJBg1BY/
	uPvbUnpWSw0obfaWadWDtLOOO1aOT6xDRuKuALfv0U/vSthO46e/FVcGWyMesLy2REbMJaMU568
	sI19DqhEBRJs2vo/6NWXHJtiLne3ToGjGj7Djk/HXB3V0K0XYEhCQXI+cU6Dfh6TUnyX4ncVNL4
	mot3u/CqP5LumGMhhqeZJs0c+j8y/DM2Xfoij30v7tM00lN2RiK23f6ca8YiUhUFSsX9KQcJ+g7
	CIU6EciY8Z
X-Google-Smtp-Source: AGHT+IE4CCFgX6WgpfruOqzSmBceJrAO3FeeVjUEHkbLe2Vz0fVtKjVcqofxxG2CJYN54iLsGj3qsg==
X-Received: by 2002:a17:902:ca91:b0:269:a75f:e9d5 with SMTP id d9443c01a7336-269ba5628f2mr11631335ad.42.1758240196866;
        Thu, 18 Sep 2025 17:03:16 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35aa47sm3388607a12.5.2025.09.18.17.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:03:15 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:03:12 +0900
Message-ID: <m28qib8g1r.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


On Thu, 18 Sep 2025 17:30:22 +0900,
Johannes Berg wrote:
> 
> On Thu, 2025-09-18 at 16:39 +0900, Hajime Tazaki wrote:
> > The commit 8fe743b5eba0 ("PCI: Add CONFIG_MMU dependency") restricts the
> > PCI base driver to depend on MMU.  While nommu UML _can_ implement PCI
> > drivers over PCI devices (e.g., virtio-pci), the current nommu UML
> > doesn't implement it.
> > 
> > But without PCI drivers kunit complains as config for kunit
> > (arch_uml.config) defines the dependency to PCI drivers.
> > 
> > This commit fixes the issue of this compile failures when building PCI
> > drivers with nommu UML.  In particular, the fix is to undefine the
> > constant PCI_IOBASE to be able to bypass pci_unmap_iospace() call.
> 
> This doesn't make a lot of sense to me. Why would we even want to build
> PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> 
> It's not like ARCH=um with PCI and NOMMU has any value even for testing
> if such a configuration cannot exist in reality?

totally understand your point.

now I see that we don't have to have this work around by using
--kconfig_add option to kunit.py.

# like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n (in addition to
  --kconfig_add CONFIG_MMU=n).

so I'll drop this patch in the next version.

thanks,
-- Hajime

