Return-Path: <linux-kernel+bounces-783696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA3B3315C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A30205885
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172502DC32B;
	Sun, 24 Aug 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="unbVP/Uu"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD71C84BC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051857; cv=none; b=p7LgnyOvYkCTLtjsyyN83wRn3XK4CnWTSwvf+qz8pO4PgMYH3gjC9o9RwclGyWB5y7Ga1TMAK3JLHDmxvORf/7YlXLeKz2xQW/TNSopejZlEAQ/OZ/MNx3sL4KLK+wDxH6sHxURtuop/iqc5o1xfMlc7WB/BgVy4EoCJop/YB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051857; c=relaxed/simple;
	bh=x0bMF5B9tDvXdbNljtpMp9oSkN009vSkXfIvk5tNQs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZqg+8XQN2+Oj+U7d/6NH3TAOcKpLt+wH5zop7OfLCHQs9iKcRgviiNMC04gQ8nicj7i2ume7q2UEKQ6o3cYMEYDHNtNJbVjZnS7MiRGyqC3qqhsagj75aDdQkpMmPCef1XqlzZLQslEjRWd5C+XC1gNbaebkKe7rFy+EkSDMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=unbVP/Uu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0B20C1A0D62;
	Sun, 24 Aug 2025 16:10:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8F8D605F1;
	Sun, 24 Aug 2025 16:10:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8ED21C228A5B;
	Sun, 24 Aug 2025 18:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756051850; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x0bMF5B9tDvXdbNljtpMp9oSkN009vSkXfIvk5tNQs0=;
	b=unbVP/Uu79ICK0Tn4oHFWqVD5VwJOm5ApWOMpoOGEZaOUX81uKFOCXuZK9sF+W7EK69omi
	4JtgkzUndZqu3xFUjcqQfwcYd1Z+M9ViAXuap0+8pdlZhY1WStERsBcTi/qCc8SH6I9zB3
	5+Y3+CSMoRD24KlQqx0PynrsDaejve3u2VIPGaMl3A2hc+109kpk3vsfBiqOK8T2wjsJie
	ASzFyXLlSrNXNfOsleXK1EgOUo556cWD9UZx7V9ohBf9MCx4adZhPcG426dSMpEedq3dxA
	xsGD7zeILwjDDK5wteFmKsPd46DK3oJBpEMJH8NrYYlt5INJhnl1x/2oEO2/0g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: layouts: fix automatic module loading
In-Reply-To: <20250819112103.1084387-1-mwalle@kernel.org> (Michael Walle's
	message of "Tue, 19 Aug 2025 13:21:03 +0200")
References: <20250819112103.1084387-1-mwalle@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 18:10:37 +0200
Message-ID: <87frdgk8ea.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 19/08/2025 at 13:21:03 +02, Michael Walle <mwalle@kernel.org> wrote:

> To support loading of a layout module automatically the MODALIAS
> variable in the uevent is needed. Add it.
>
> Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devic=
es")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> I'm still not sure if the sysfs modalias file is required or not. It
> seems to work without it. I could't find any documentation about it.

I do not recall how this worked on my side, nor if it actually did with
the latest version (there's been a version where module loading was
requested in kernel code, and this was working well with an initamfs
IIRC), but that change sound reasonable.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

