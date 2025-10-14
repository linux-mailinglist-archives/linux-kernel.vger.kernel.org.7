Return-Path: <linux-kernel+bounces-852040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD11BD8038
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E14E499F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A4030E848;
	Tue, 14 Oct 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bM2vIbQ/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A530DED9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428379; cv=none; b=Ho0JJrlfAWVDLW4UpLHlCQ9nOm+hPba3EK+3HANv+ZCdNmXE14d+4ToOnw7GeaXBWhNlpWlxx9qPKy9/5OboIDVMPOzhpP86f1t5il/r0Z47nDtJPI6B+syigynDc4K1uM8bw/yJd6tbeLIy69M6D0EfOsh8NFKY9zozyrfbDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428379; c=relaxed/simple;
	bh=vwrJbLqYUIs2hdIZr04E/5ekc/E1RfYrlr8r6ix4a88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNBye+GyeHDrJtc2lYMRww8dk386tgHd2WNjXa2ZvkNq4z/SCDGseNOc0YnvFRCgsN/hxjiBfmihRxxaTsfgXtU4D742MNRPysOmTKmFYeJHS/VaK6JMZ+lNcAjOYUdBjSPHIHUN+KyM0ekcNzqVf4tDSnUwsbcJ3/7DVFaq09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bM2vIbQ/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so5755348e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760428375; x=1761033175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwrJbLqYUIs2hdIZr04E/5ekc/E1RfYrlr8r6ix4a88=;
        b=bM2vIbQ/T7wKhEPoz2u2iP2U8eDm6ZzLXRuCTG5L+Nkr51c1LuJO0bnYR5o/gOJvLJ
         PqMc40rxLILHumK5eOrp7azICvxkO3KgyPSvqb9L/GkSFnRDu2veAiFq3pAIFyXBQr0b
         GioXqiHn/vNKdtDIdIOkaVQahGRHf5Kt/XRWYUqbfIG6dWC+YTVexptKCupumVkpbLzG
         sp759a+6uTPxPalIb2sEs/LhyfWSGQNUHtoe46r+K2PqXOKLTSIO/y3Ep88ZeHbGZxgu
         5yeNFepW76upTfrjLPqVsrwBditNkbF4shMRrte9f3NvRm540BAH1Yy+1iDXI+G4HR43
         SGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428375; x=1761033175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwrJbLqYUIs2hdIZr04E/5ekc/E1RfYrlr8r6ix4a88=;
        b=HN6U+NLO+ATV8gko7J95Po9DvekqwSgrnkzOZuocLXxeNfH3XUSOOtesAumuqsLCjU
         mPNNHsAm+4I7uNSKbr2X33TIqVfanpdDG/Z6LKDDmITNgQTCqN38Q9227mL5pO6MX6gR
         ogZWrgXf4kMPjpA2sL9P/scASEhEVbKibApO6/lxLnWH+pcR0BHORz44EKFbZFroXYUu
         I8lyqoLcN8cULuZPKZV+kJBhM/bQGE4xCEEDTJLDIy18uiz+FO15FjzkKcblciP89niW
         5bmtaXMxhuLzYruFuX6+h9UTKf+TL5/PkV4VuIMzqpG6JwJnmJi3XZMt3P/xg3NdMzut
         u62w==
X-Gm-Message-State: AOJu0YxFNzvTaMZB7Ck4hM/CTa/J+JAJU4dfQcARB/O+on9O1uXg3acZ
	niOm0czuMQ/NZTXEbH1Qbqk7IJ84fKjZjfVSHcj0N4F2TFkfvoZcDUYyHf2g5of7l04HDcBlR7k
	QK+A6Sh6KlwMVw8YEBpgmukwt1AKu57Qyt2q7rOku/w==
X-Gm-Gg: ASbGncsItTZX8S7clA29ESc/w0q93D/Ma1FxLkuFtbQTlPWcdxmcyFTkPknCw71iwNc
	TEm77BLEVzG26sTHDdNwf9XVxwyeVAf+3v0SvL3yDtsUTldUSpAs01bUmRZGsqmqEQKjXCt4+Y9
	iUJSa5it+2lDk12xRoDx3BztgSwCHmAkDqyemgzF78ODncNBa9YWY15pkmPn42ix+d0JZwe8iV8
	7c8RTjU+mzq3wd3se6OCUqxdB7FyFI2Yf2ajVoh44nskWpgWuabT4UHBU0=
X-Google-Smtp-Source: AGHT+IE6gg+MLBxMH7PzBTZswQ1htTybiRf8di7CCXjc7HVRjNQ5sXwPlBAm2r4gvNL/pfqQj+6D1NfuyxLQ/PTPyB4=
X-Received: by 2002:a2e:9a12:0:b0:336:7c7c:5ba5 with SMTP id
 38308e7fff4ca-37609e10855mr73524151fa.23.1760428375403; Tue, 14 Oct 2025
 00:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919153008.324338-1-marco.crivellari@suse.com>
 <20250919153008.324338-2-marco.crivellari@suse.com> <CAJZ5v0hvTogN-egwXWRp3F1iJ0HS_eSJ4hEavjrMuKF5RVxuHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hvTogN-egwXWRp3F1iJ0HS_eSJ4hEavjrMuKF5RVxuHQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 14 Oct 2025 09:52:44 +0200
X-Gm-Features: AS18NWBEnf1NwISRN12NIVApf9Z9zdxOb-FVRSihzo52lcsL7sWcjBRM1cAsi1s
Message-ID: <CAAofZF45x0y1a8bEbv9BrPgVp8EGbfPYTjvL_sv=xnf-r80u8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: WQ_UNBOUND added to pm_wq workqueue
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>[...]
> Applied as 6.19 material, thanks!

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

