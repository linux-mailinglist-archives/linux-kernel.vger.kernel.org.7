Return-Path: <linux-kernel+bounces-896243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCB1C4FF38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABCE3A757A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB534326947;
	Tue, 11 Nov 2025 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYkfuYLu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9926B760;
	Tue, 11 Nov 2025 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899157; cv=none; b=QlTM7x8FdLnG+kzSdDCo2odqKqnZpKavoRcg3d22w2t7CEWOctUZkmI/GACU8QpL9CZaZHat4DaLi6ON9Fr2yhVH+GVjEtM3BUsXX4Ji75xJWUWo8ZQENeBp6NsLhGQ3qKvH42LsaOFqwr/jaDPkjfbpnkcmwYpCMBhj2P6d/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899157; c=relaxed/simple;
	bh=ZLklqjVCrUJKrQ4kf2OljEEwH8s38vtS5NOBd0PBQxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDZe0YJqeY50JewoN+wVuP7NoK43XLirtFvQMtlwgx0LEFPQTfJRaxTSGfxmKcuqXwKF5cHTPr3069yXK8EOztF9bWMnoa1K/I0SXCJ72ngQHIz/1fxhuGBAvuyBncOX3LiAo/0VP9wgNxuhakLRPfK3FrWJZsnXJDcqeYlgy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYkfuYLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4C5C116B1;
	Tue, 11 Nov 2025 22:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762899156;
	bh=ZLklqjVCrUJKrQ4kf2OljEEwH8s38vtS5NOBd0PBQxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hYkfuYLulwwmJgEzBcsYi5xTmBMA2FhUH1uarux4mnCBeY9td5mC/PqNkbdCgHXkA
	 PIq6U+sxUsTvdRir7LoRxwUi+CKTflvMaBcDSxTWY+T2xw9gqJspXwoMlg0Ct5fwb4
	 VeOy0qoeCGwBbiLE8g/IDyUi5pI/4H6bZGnauUncEQdf1HyoFrr2jGmaldrJb0Nzjg
	 a5omaLT/0LXOvmiEwvj8D/8hDS6fNsj2gzZJGK4uVKLhb/3ROsgisqeBmS9iyUAiSh
	 2RnozvwCRIMR5zHmwhZssp3eg4W2MqCv52fNnMZR9jAtr39D0V497yBHWsF6joMcC5
	 jWwA2uGoQIt/w==
Date: Tue, 11 Nov 2025 23:12:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert get_feat to Python
Message-ID: <20251111231232.3955f1fb@foz.lan>
In-Reply-To: <87a50swl6d.fsf@trenco.lwn.net>
References: <cover.1762877066.git.mchehab+huawei@kernel.org>
	<87a50swl6d.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 11 Nov 2025 10:09:30 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > That's the final series to complete the migration of documentation
> > build: it converts get_feat from Perl to Python.
> >
> > With that, no Sphinx in-kernel extensions use fork anymore to call
> > ancillary scripts: everything is now importing Python methods
> > directly from the libraries.  
> 
> This, of course, conflicts with my library move ...  Maybe we review
> that and I go first this time? :)

Sure, go ahead with the library move, while this is reviewed. 

This one is trivial enough to be rebased on the top of it.

Thanks,
Mauro

