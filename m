Return-Path: <linux-kernel+bounces-815642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2729B56955
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EA417CE24
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F61A4F12;
	Sun, 14 Sep 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKFwQaXj"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8031373
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856614; cv=none; b=Xw4sPng5NB5dYTgV5fbZK+Z9IldGYJdw9dsXery3raVjWgd8TePoystNuw+hdhC9k8nHjxrQkfEI8H17iqIRicubx8V5u9gE47lL2mAQ9ewe34f2Uzu209JOLlMV3pZN4sry1uk11A6dEhwLDg7KmKal+ZIOrdPLB9EAWnLieP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856614; c=relaxed/simple;
	bh=sdfxBxt4mURTAIPeCtfkcBrYZDH9reEz+rlyUwKcLO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtw+ywposYEfB2oc3lxXMLRGzGAYiqLyqowx0MYt+NZtQ6gCTy+vtG7Ai52BEKR9WPo/9qp7xnGEHg8O7O2EMl05Rh4CHC5Xhz2lAqzVcslWn0Zijp/f7JJa2MOxA6MZ/pNwBjGRhMyIJjzm058PsjwHyB5dvagaxNT/VkXWPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKFwQaXj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32de2f8562aso2622003a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856611; x=1758461411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v/bwFXPYi1A/E+v0RDwAlOzUIE6ZiAt0F/hgL23dj4=;
        b=gKFwQaXjyaB0t8kuU+1qI3ECYcC7aui8imTZEfEWOe+i4YJVvGhXsfFfJyjUDikCq6
         l6Mzp+i5U4E8Wwj+wvX8+70LywCCAogjUMfirklvvHA0mOm28TYPewvmayuGSxdOaf/r
         4IeYX/FzX/CrCA1cmu2toaDzI28szBbOaVjAEHJL7BEyADHG5F2RYW8+xdFpArbAbEoS
         YFu/7RobKHy8xitduqC3ZIGjtFRVVsUHhjW5Vy8mr3XTBdPkLTwjEvaFJki2POpSrO0i
         B3470g+P8GIyHYzvdzdmqMLinCSPTtJjGdbqQaN6mRJSTFg5NgMrc78jebFMWeazzvZ3
         OPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856611; x=1758461411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+v/bwFXPYi1A/E+v0RDwAlOzUIE6ZiAt0F/hgL23dj4=;
        b=maM7LhR1dsmyXCrMEgXEUdy26EBCeHBODFJ9vEv2Yp9AZiIs7IAIWiAKapr03ONISe
         VbLK02OFdqvMby3FYYHmGzqDMiqTPdt0ckKfqL3YZh2Moc9YtV+x2erFXUnEDBWaiOeL
         ZLfsRph2bNbEai7N6DuSBUM5fna1wTEYyDQCjaRdZIBKs/2CH+w5XnfgNtruxRRrQZCx
         rvUSdnzLgIu2rKrzgYTpaeFD+41JSShCo2RDaEDjtbgsFPfWQjhNAutYnKZhlKzGzUll
         aohjRE28nw2YQqEUsI62EjNgp6wlIPAYEMfzRs2iiwdQTVAyk02UB2NdNaEhEwRYXM0J
         zKeA==
X-Forwarded-Encrypted: i=1; AJvYcCVzWfSG8OmQmtKbJoM1H/0sfDlThx7iNoWbjheKVEta42zloCbQOWHU3COxNJjwrrXbpeSAsbHRJqrXjPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSKN5XcE7bJOKkFJE6jiEe+bWg4uUmlE4Y+LiB9WDCpC/z50n
	oZ3DGVAcgsD3RR5JStrtxc/6G6y/09xjUjlIAcNqB9YpwdL3TYn+hF83
X-Gm-Gg: ASbGncvUzEJP7FN5HA9CfSIiyW/6zwKq7AeQgR+l1wr0FUeOgqnQ622YuM4N86TVU00
	DtMH1vDNAP5lfPAGOAO+MG1QesnwGBkfBObNdClbMaxWPVT1AYPrx/MVM57O0q3EPNLmQfK04mR
	Rgqbn8TOzcqKZ0M4QtsgrPxCFCHcx0UkUWAxMRFV/OyRMFwRcWPqx25qxKLno9gHjk0sSzsyMPs
	BKzkh1KsFg/GAckJJGVfc7rTwI2WVMkn+Ua8gkJXlnQ6xYry4VmUAeW7FfM1/v+UhgFIHrDjcDV
	zqaEamLZo8dxFvNXLUF9QJSp3b9izoBQb/8LJsuu3Ak+6ZVInA4spY/hrk2PMn38BSBdabqAFrZ
	U6m1b/uio4/IvXmCxWFFjzhAAdvHnx1PFFwX0M4vAi7MI
X-Google-Smtp-Source: AGHT+IF1KcNJt3UWmfwSpwE/UpWBqDtmNxg4KMzYyF8MLuCAmlCdngCBSBEjT/SyGByGhBx68l8iVA==
X-Received: by 2002:a17:90a:e184:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-32de4fb254emr11960351a91.37.1757856610930;
        Sun, 14 Sep 2025 06:30:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36c78b5sm9622382a12.21.2025.09.14.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:30:09 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: kernel@pankajraghav.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v4 0/4] allow partial folio write with iomap_folio_state
Date: Sun, 14 Sep 2025 21:30:07 +0800
Message-ID: <20250914133007.3618448-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <mbs6h3gfntcyuumccrrup3ifb2dzmpsikvccu7ovrnsebuammy@if4p7zbtvees>
References: <mbs6h3gfntcyuumccrrup3ifb2dzmpsikvccu7ovrnsebuammy@if4p7zbtvees>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 13:40:30 +0200, kernel@pankajraghav.com wrote:
> On Sat, Sep 14, 2025 at 11:37:14AM +0800, alexjlzheng@gmail.com wrote:
> > This patchset has been tested by xfstests' generic and xfs group, and
> > there's no new failed cases compared to the lastest upstream version kernel.
> 
> Do you know if there is a specific test from generic/ or xfs/ in
> xfstests that is testing this path?

It seems not. But there is a chance that the existing buffer write will hit.

thanks,
Jinliang Zheng. :)

> 
> As this is slightly changing the behaviour of a partial write, it would
> be nice to either add a test or highlight which test is hitting this
> path in the cover letter.
> 
> --
> Pankaj

