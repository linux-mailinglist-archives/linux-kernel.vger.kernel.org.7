Return-Path: <linux-kernel+bounces-779781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7445B2F8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD675A6D17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053CC315763;
	Thu, 21 Aug 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ydnd4lN1"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3D31159D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780258; cv=none; b=iWGvK1ynquEVyk+7tBHtZOZNiXPTjunQiPF6mOLkDI7OMDtSEa9ewpbYrMZhd8kZGbpqu5Isi3pZhnGdMJo0CLGxYVzPBoy0Q4cBFy85jwXEOAJSE/UUfVXWwTHd3tspQjsHvc25Mf4+/V+vNGeZUUIno8aGuddkxwHJiQm4B3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780258; c=relaxed/simple;
	bh=kh5QYdAh6nAxq3wHVmiK83eqHqd1Ae70oDTSD42Qpis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iVByoV+DEH/0eKNz9gk8w92sb5MMJSQT0Ko2cR7aWqi/+Ye665ix8O+dlu7Ss+tlQ5d+xr9NM9D4FT3T768OK4iB4ODtqRnHvXNcw2pU6tbO8qXr0hIZkmVXYfE/KFcPVscriokgCIL36F9MXESFYJyzJe9jFRqd7g6HBPJaCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ydnd4lN1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so5999495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755780255; x=1756385055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kh5QYdAh6nAxq3wHVmiK83eqHqd1Ae70oDTSD42Qpis=;
        b=Ydnd4lN1En21y6x+e1isqj/cIcMMtWZFAQoxdfTfR3Ym8KmNOLjq6P4ps5EriWuPyC
         zeZrvnt7jIwr1mMDp3Rh7ilssQTysRVB8T34OHZpEHGbUgUDb9Rmslo92YSNoam6VvkJ
         ZNpWxXg6XFOanGpr1uGgzWPT0HxVjsooRoei0sSQNAhUaANqcc/FAVLh34VyLmIMEZDm
         kN1K8ms3c9GD3DjAua4s/V4TYENif3m0tqO6CkMG0rxx4QCjoyXt3HxAdbQfSsErzAj+
         bzNtq5+gXk8h+xPkNlNj+JVuwFA8HIQzrbrJk7YEzDPMmjn6zaWR9owHnz2FAZQt3Csm
         eNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780255; x=1756385055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kh5QYdAh6nAxq3wHVmiK83eqHqd1Ae70oDTSD42Qpis=;
        b=BApPT8CAKDE22B5/o+ZYm+VRGD/7sm9L59GpZaRivEwcmIaXiGmfeZzLIUErljgD64
         eAMX6cm1dWIaygik2PH7oZLBGgqV2v2A57oq6t0tnk/+VUOiolvaLkJhccBspPLUhaLy
         4uTS9CThsC+ISp+reC0QUNsHDX8bz7dGaUngLpLm2mEXDU12pUEzYG/yN4Bi/4lhbcFO
         6cIn3VitfuMkRP9TgbGy/Fd4mUCoy1wYNs9ZLdQ2SgTHvQHmbPP66Cy/Yio13W7+HpSy
         iePj2RWXaFAofFLzooJvZubLfLyMxAGaLWCqSHpRexSxXbPQbCFgihJ6sGS2+7TOdzrs
         s7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW9mjwP1w9Hcqvyky3jaw34fEJtkU48pyOAN0B/cf6sbjGCYlphpcOK0b8Vabp3bcGE1DPhSLzPOAoD8sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrzvbRg4f+791vpbvzx604g0LFRtjI2/GMtMo7gA/xwv0Daz1
	dRHi4E/JXNFzo1mwwR6Jkq0wqEmKONx1BpfKGh/M1iHFLKFp+Xf/Pk/ojbP04V4C47wRXBUbHZK
	KReDMBNDbaXORDw==
X-Google-Smtp-Source: AGHT+IHAROi3MrtrJw/aU/9ZmYqp2tOlukwY3bYbBdELumt2D0HPjVm8FpMPMoJokOc2rHfbgvTz5uNpauUQ3Q==
X-Received: from wmqa19.prod.google.com ([2002:a05:600c:3493:b0:459:dbaa:93a6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3541:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-45b4d8587a7mr22616175e9.31.1755780255050;
 Thu, 21 Aug 2025 05:44:15 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:44:14 +0000
In-Reply-To: <20250817065211.855-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250817065211.855-1-ujwal.kundur@gmail.com>
X-Mailer: aerc 0.20.1
Message-ID: <DC845LPNX9EW.248S4JXKRUJAP@google.com>
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, <akpm@linux-foundation.org>, 
	<peterx@redhat.com>, <david@redhat.com>, <lorenzo.stoakes@oracle.com>, 
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <shuah@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun Aug 17, 2025 at 6:52 AM UTC, Ujwal Kundur wrote:
> Refactor macros and non-composite global variable definitions into a
> struct that is defined at the start of a test and is passed around
> instead of relying on global vars.

Hey sorry for the delayed response here.

Based on doing a range-diff vs the v4 that I reviewed this LGTM,
thanks!

Reviewed-By: Brendan Jackman <jackmanb@google.com>

