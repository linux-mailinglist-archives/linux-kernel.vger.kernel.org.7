Return-Path: <linux-kernel+bounces-792565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E2B3C5A2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8E95858AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4568270542;
	Fri, 29 Aug 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9aVLE6d"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE920273F9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510672; cv=none; b=BDgReE26c9Xoo4Jx5OwFm+ox0skhQTFcDrnzhZnVnkg+bZANNf4MX/lNsJuhUItZ8hm4VygCkCecHV4SqfBywxsl/IzCThgkyJTjfdjIWaIG1UcQOz0zWYyDModxX0/LlWR33bIjB7j8Ew9c3mXLgcLN+EJZmYnGhwukQWbsfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510672; c=relaxed/simple;
	bh=wjucbZ0gqK9xXst5o/FSMlWx41GizlxidOxubSZ+Ek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tClLybyAJ2L3fWWC1MGIh/5DH7D0H09PfHvPjwr8gl4xribPyafQiKvDSRXw/yECB35npB2c6rVJjoQF4AcYWvILZ7TiB+eGQHqvicgHU57K9lv4+mWy0rWbCyfvmLV6noVp3uqmRn6XdSnI562wHSTr7uKrSw7Yh4aP2iM6VN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9aVLE6d; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24a1270e0deso170245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510670; x=1757115470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00nNOb3Yr2JjftLjYszdKiFKnSXcNfFMIfSlPiSZF2Y=;
        b=G9aVLE6d3ROI79eG87N6UsU+uOQscBaWsRjGXngCPMqloNxqd5rCLDaCDHMry0YMK3
         +R0up57lK8MzQqK+j5vDRmPFyLsNYOi+gZm4CBkcrGlAzZq3NQa+rfPiXc66CVB5mjoC
         WL1kxkpAQNNe908jLa3iuEs730RYbAlR0MGe6dXBsrCm8RILklYIhCIF4M1+wAWhRUi7
         0kgJR4iftZE8pR6uAfKVQXzu7K+Q9OFnPxqnY2RT7sz3Nqv/X+tHDTpMzldZqEGDFRtu
         ZQR2KCExPkLGxF5LIctzouYEteCWll7ijrbD1C0s5hdQyuK2dFnA+PklZrshhKx8skmJ
         A31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510670; x=1757115470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00nNOb3Yr2JjftLjYszdKiFKnSXcNfFMIfSlPiSZF2Y=;
        b=rQ6Or3R8YoHp3zw4XWOevNCcOhaqAtuROaA3RG+ysYMyzsw7EZFFG1N0skT9a8w2y/
         Q9iOd2gi28x2w7ph1vlTN3gyif5VjD/dMSlAjBA+qUQpIg6mCmyH8UvYaEx7xATIW5LX
         uc7howDevpDSl7KRXPrhFx1l/2IC9PMIAN10X3G29RT0e+KHRpQrmjWYIV2qBvBy1Y+L
         CxtLgquLhw0PxB1ra6Ywn3VZhd0jlOZGIdeTJo8QERrfzMMT763I9GNiYjnwfHj5yDgK
         12djjhMkGqR7kfhwU0pw/ddVld9KYJ2u+5kNMwQXPimSjgEwGOSJNj5DEfcS0OMVxj33
         srBw==
X-Forwarded-Encrypted: i=1; AJvYcCWERHlfyP5yX/1iuby/qt8pNyE4ZFmXYsVMV3vWGLSLZUVVVzO7Vq0JHDO/QWs5XrRh9x5CSjhvqxIUGpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvt4ngnqaiY6X6UeNp33oawZ4FLBi37aQvJ9RnBsK45OzGrnnM
	jeE4fojOA0uvUCJ1Fy7R99yB57/m4reNxpL8T4knKe3FDeuCBhIF6rJR
X-Gm-Gg: ASbGncv1zUfOssXeub6vq9nQLrEZqClyNmF4rdex/Gq5mb5oiX6I8BJlhxSc4KQFctb
	h7aY9sbon4joZ9KIrofb15xYqooH0UrgYijsvXpy1uVEBVsPuSqeaeyWfqEBNvUR77qtH5CRTRW
	DQggceQPGBq4qLOl9bWCmO23QUdQAkDNqmIWgo2pHXeeBdlooIr/7FEqHFMvBQIfEwD7tOx+l7G
	ENXD6UgFkDHukz06olHl7yHUR/h/Uepo8sedIJ7brb0Yr+bTPJ3mXInpDqhmkmZ758wH3+4HPIx
	MpRg0pMLA2X6QIzlHUFHKLgT7/1Oj+GqNTeefCodsXfuTEBTJPYlaPaPuknYYmKtjdfwbXu/ouS
	nu9c57FODdRuDIKUjjW/t0hYZqTU3+U4s/oMyOud7alXgTJyRGffu2H3COJIugX+2
X-Google-Smtp-Source: AGHT+IF5vUBxwOQDnV1jhVRxjdOQuWmGB9yjHYlaRmjnxZSBLBzUup5rMuhJQdyVawbFiZopAgbdig==
X-Received: by 2002:a17:903:15ce:b0:246:de62:e0b with SMTP id d9443c01a7336-24944a9baa9mr4866795ad.29.1756510670291;
        Fri, 29 Aug 2025 16:37:50 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490372734asm36196035ad.42.2025.08.29.16.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:37:49 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:37:47 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 10/12] include/mm_inline.h: add `const` to lots of
 pointer parameters
Message-ID: <aLI5y3lWdJgfLnhU@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-11-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-11-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:57PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

