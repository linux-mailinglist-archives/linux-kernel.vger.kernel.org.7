Return-Path: <linux-kernel+bounces-891700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53499C4347D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 21:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101DE188A753
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DC4280033;
	Sat,  8 Nov 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCmdqD4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AC1EDA03;
	Sat,  8 Nov 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762633116; cv=none; b=U6qPFm4+ElfrHHuXis5naKpaFqWvSru0SFGIVZX2MqRazvrvYqRrI68+yymKV5fbYDlxnglXmmx/QyrRZdJRSgDDZl3deHnJxyDxUjYmEti5eQ+pEyvYXJnQtaFIYLmJovMFhMNX+1K2Hg3QZHGJuHT0pJ+dFmMq+UVlUHnit2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762633116; c=relaxed/simple;
	bh=9dFaosqCgdk/kEUqXmGk2ZpoAofn1l+gJyHkdZBbFvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1RbH52u4K0ZzgKkoqVYoGI6VzPkA4oNZl9N25hO08XXYdCWpqB1OTNNj50fCcQgBaZyX4kGVGHE9Iv2AeHmsxcqRni70KMM+h3Qg+5OPZJvAmxBbh9a86XMkllOKDNCoa/BCEGnue1xSwLjYJ4wE+ck4Ng1/CgA1tgmmyvzK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCmdqD4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7C0C116D0;
	Sat,  8 Nov 2025 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762633116;
	bh=9dFaosqCgdk/kEUqXmGk2ZpoAofn1l+gJyHkdZBbFvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCmdqD4+Zko4Oh08xEIiJU/GDwryT8oMTjud0s+o/j5hKeXLPu54kTYzDzm2lA8vZ
	 7S5CrtyWSMNKKdoi/EGKmP7oG0bciRte/nNShb4QWOYVoAkhSfcchfm4akoo33cR44
	 jqQ3mEhH+BgWdcMC/9i4p7BbrqZGa9oKsPyQU98pW7bH6cyDFIdnpqloMfAaVJUYvQ
	 U0gm+3UHbyZxtWzZr09mcK85zdsebo0lwc2UxDG+ZZtBDKlLmVMGMosf6Rrj9mGLVx
	 kEKbLcFe8j+lCR1hrTh9DYuXie0aTMHUz0SdIGk67Q4s/aGrJhitqiJKMStBqNL6Lc
	 pWcOFasIqDpHw==
Date: Sat, 8 Nov 2025 21:18:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Markus Probst <markus.probst@posteo.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Support power resources defined in acpi on ata
Message-ID: <aQ-ll__G8ZXyGtx2@ryzen>
References: <20251104142413.322347-1-markus.probst@posteo.de>
 <aQ2zI9tIb5asD16k@ryzen>
 <yq1ldkggz1s.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ldkggz1s.fsf@ca-mkp.ca.oracle.com>

On Sat, Nov 08, 2025 at 01:28:23PM -0500, Martin K. Petersen wrote:
> 
> Niklas,
> 
> > If you have no comments, is it okay to take this via the libata tree,
> > or do you prefer to merge the series via the scsi tree?
> 
> It all seemed pretty straightforward and given Damien's reviews I
> applied this to SCSI. If that creates any merge conflicts for you, let
> me know...

Thank you Martin!

The changes are very self-contained, and essentially only touches
drivers/ata/libata-acpi.c, so I do not expect any merge conflicts.


Kind regards,
Niklas

