Return-Path: <linux-kernel+bounces-844064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DCDBC0EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06F419A150A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F454279;
	Tue,  7 Oct 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P06CLCbj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6712D6E69;
	Tue,  7 Oct 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830548; cv=none; b=YmpoA0yQWUgYv1m14lF034i4ePklFMrH/i8sFmiAW0oXBWfQ1KYEqNdFU50OzgCUqGrfvnlMLigtu+cXRAGb+yRYVRdqURMTz6jqDdRJeML7joqIcx7fwJ8M82XZ7Dv5sm6LtXN9kAdtZmZTLmubRDYBMB+hrAR04+6+EgHKvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830548; c=relaxed/simple;
	bh=kVze0IcDlz2q6huoycUhhgzcDzH0kEY5NY4oslKvcYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+//844wlR0n0IDyWHDcxLerhF7qoHB3O/HQA+CXkgwPdvJBM1GwITmKMbG61vckM390riouhqMChBNEQeEeDBIDs8GOYPGpFGU0QrWHknBDwj3CgNT0pqj63/vLHNl2r5R1xPwrnR8eklNpjgr156cWQ4hiwU02TvW8/QqVp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P06CLCbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FD4C4CEF1;
	Tue,  7 Oct 2025 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830548;
	bh=kVze0IcDlz2q6huoycUhhgzcDzH0kEY5NY4oslKvcYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P06CLCbjosZTxbO2Op9lWmkIRnp/QWnNg+W8hucUpoeBtJpa4Q0/ybAvWqJHWLwzX
	 kU17Xoynvw8jNC4OZ6sEREk1L6F+u55IdHiZ/Y0Pp0mxEE4DZpv0hIfAr2XuUpzFHr
	 4XVmngBMORWnd6yykApH3T8dswkrJDPn9EhHLlKaZUrxEkpRrREQ++LJRCg0N9zEkc
	 GM17vCgU0LxCOH+ehcappdVBWsRGqCgPBoKcSzYYg5xxwwmErptspeCL0rulSfwjZI
	 pRcgl6vlkTSgir0zJ1OvxpqrORF7e1sOM2YmTMMzdepI4gzwwGY2K6P2EaPaKdBY6B
	 RxzpKNqfRiuWA==
Date: Tue, 7 Oct 2025 09:49:04 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, bleung@chromium.org,
	abhishekpandit@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
Message-ID: <aOTiENQQZc0X3Hv7@google.com>
References: <20251007004043.4109957-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007004043.4109957-1-jthies@google.com>

On Tue, Oct 07, 2025 at 12:40:43AM +0000, Jameson Thies wrote:
> The cros-usbpd-notify-acpi probe currently does not exit when it fails
> to get a pointer to the ChromeOS EC device. It is expected behavior on
> older devices, where GOOG0004 is not a parent of GOOG0003.
> 
> Update the cros-usbpd-notify-acpi probe to check for a GOOG0004 parent
> fwnode. If the device has correct device hierarchy and fails to get an
> EC device pointer, defer the probe function.

I plan to queue the patch after rebasing to -rc1 if no objections and also
collect Benson's R-b tag from v1.

