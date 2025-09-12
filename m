Return-Path: <linux-kernel+bounces-813218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DAAB54215
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5075F7BC0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408726B942;
	Fri, 12 Sep 2025 05:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mH2y70wU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199B4207A;
	Fri, 12 Sep 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655165; cv=none; b=QdpypUqKrY04F+81ntRiPRQ4a0yCQs0JkvVbgDd3iqhFJuALTnrIlvIUs3HSqSXClp+QWYaN0XGNyJrvPMRSddyMulawZQj3veYXKPTWXxWfliGjJE/v+9fq8ISVJriozcK576h/zy6zEPsveZHXNbDxYnQUae+MIjcDcyvgNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655165; c=relaxed/simple;
	bh=jeT4qR8rIecDQlfC59jCyIYr83mRqkyal9fi9JFmstw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV3lSRu39efU7T3Kb9t7oUAK/bQ3izObL8TIoBgKNGjya7pZQkzX4Mq26FtBCEcMLeIfCIWeMYT/EjoEJHVdTicYa5yDJZ16QMU2vs4x11eG3ltyhnWVXUAo3cor1ByV2hQhF36mYPPozg+FEV94oI2r55LX7NPcbzwgwujlXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mH2y70wU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8FAC4CEF4;
	Fri, 12 Sep 2025 05:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757655164;
	bh=jeT4qR8rIecDQlfC59jCyIYr83mRqkyal9fi9JFmstw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mH2y70wUUulUe8WhRFMj+Pxezigo7Q4HBV/ofcB748Kcryitz2YpXMHru0asRNkwZ
	 JeT9Wh+wfx19Qg3RSsLoMGY+wbv9pwyT+VttKt873Nuotzornaasc47XH4LVeWEtWL
	 dUX00wum9ds5XJ6aGkpBrS0v/nJoUBkRAEgYgo2I=
Date: Fri, 12 Sep 2025 07:32:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix typo in comment
Message-ID: <2025091223-dispatch-angriness-7516@gregkh>
References: <20250912022827.676169-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912022827.676169-1-weibu@redadmin.org>

On Fri, Sep 12, 2025 at 11:28:26AM +0900, Akiyoshi Kurita wrote:
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

Sorry, but I can't take patches without any changelog at all.

thanks,

greg k-h

