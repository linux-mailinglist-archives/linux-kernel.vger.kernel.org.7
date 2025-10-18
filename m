Return-Path: <linux-kernel+bounces-858892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD12BEC281
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA1C4278FA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCB1D271;
	Sat, 18 Oct 2025 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="O7vmoUN1"
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE931388
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746694; cv=none; b=l4MGXX6xH585t/ORtNin77ZF47fnw5DHuZxOW7l04FuQTEeuRnm+VZL6BhadF9WVW4QddW0juGg2qVyv/YvPkcEPYTVVD4JlY+Udwq5kcChwowePsFwJP99t4gdIzE11EYTgWl6dR5hoPvCqU7zdYkbHttUbOf39/Kee+h8k8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746694; c=relaxed/simple;
	bh=nMCcOH3LsvFDiSoSwVzn+bMl8JggwFCUIc5JCRh1UnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJ/16XXEq5gzKJni1odkmA7mgR8nU4Ulx0INODZ13GrAN6RGib5zZdjp+7Y7vR+ZJ9HHBtQyuq4xLg9KFM5X9quChWESEKTBAjPBRhAKTdnTdadJYkYE0ld5wvx5CzB1Gku8dixgH+3fPvtmBM7Fauz0Wn0oPF3qm1aiyUPHaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=O7vmoUN1; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1760746688;
	bh=6abL2+5TdRDXHj5K2UZsVchQ0aAKfL1TRVZ/hY0u6/U=;
	h=From:Subject:Date:Message-ID;
	b=O7vmoUN1EMEsOh3Td6Mt+4/0GBcE/HJLkblsfn1AzbRmgA7vJg9EygWIRyUAUaGhR
	 E428z5Ewd6P99jY62cEqNNUEpsfoM2X/KlC4udQV1RZKGk55WKFLz7lq+Ja3bpbTAt
	 nGalcilPzQBQNuV8tldm3ijlLoQYG8zNRGfa95QM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68F2DC9500004450; Sat, 18 Oct 2025 08:17:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1788674456905
X-SMAIL-UIID: 626E1FBE367746C6AA11BA8380028A8E-20251018-081727-1
From: Hillf Danton <hdanton@sina.com>
To: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	kernel-team@android.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
Date: Sat, 18 Oct 2025 08:17:12 +0800
Message-ID: <20251018001715.8621-1-hdanton@sina.com>
In-Reply-To: <20251017233907.2305303-1-wusamuel@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 Oct 2025 23:39:06 +0000 Samuel Wu wrote:
> +/**
> + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> + *
> + * Return 0 on successful file system sync, otherwise returns -EBUSY if file
> + * system sync was aborted.
> + */
> +int pm_sleep_fs_sync(void)
> +{
> +	bool need_pm_sleep_fs_sync_requeue;
> +	unsigned long flags;
> +
> +	do {
> +		spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> +		reinit_completion(&pm_sleep_fs_sync_complete);

Given difficulty following up here, can you specify why reinit is needed?
> +		/*
> +		 * Handle the case where a sleep immediately follows a previous
> +		 * sleep that was aborted during fs_sync. In this case, wait for
> +		 * the previous filesystem sync to finish. Then do another
> +		 * filesystem sync so any subsequent filesystem changes are
> +		 * synced before sleeping.
> +		 */
> +		if (pm_sleep_fs_sync_queued) {
> +			need_pm_sleep_fs_sync_requeue = true;
> +		} else {
> +			need_pm_sleep_fs_sync_requeue = false;
> +			pm_sleep_fs_sync_queued = true;
> +			schedule_work(&sync_filesystems);
> +		}
> +		spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> +
> +		/*
> +		 * Completion is triggered by fs_sync finishing or an abort sleep
> +		 * signal, whichever comes first
> +		 */
> +		wait_for_completion(&pm_sleep_fs_sync_complete);
> +		if (pm_wakeup_pending())
> +			return -EBUSY;
> +	} while (need_pm_sleep_fs_sync_requeue);
> +
> +	return 0;
> +}
> +

