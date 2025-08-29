Return-Path: <linux-kernel+bounces-792555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9351B3C584
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00D8564ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825C35CEA3;
	Fri, 29 Aug 2025 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLL7PWAw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454335AAD0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509083; cv=none; b=qcilhd8v0JUKUL7yH5+LtNicHggwgPVqce0RjAvTWbbKfAkF9k1b8A1cSYXH5UM3p4eNg/imVrByXTJ7J3kim3wHo/VHRPW/4fgRYbwEx/dtFQ0mkVOoMUKqFKAsSflKy8fjSFeI8LV8NxFOfbWK/iL2NugmO3GIEUf8GxPp8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509083; c=relaxed/simple;
	bh=yQKGP8CjJ3CWp+27fBJtpu2Ootrvwuc2/EabJrmTcS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDvVuk3uOtMQ/zytGyLp8SxlFd4YIFZW/5WSZy9z/eFKR3JOocqwg+hb4Hzx+ubrtz3PIqj7JPTe/5XNCjtqc4pT8EEhsiCW0VWzthUsFZN1C2CQNa3qy61JO//AqQAq5xu5Blkz0Qnx9MDZA7R5A23edbHjo79ZmLrhhB35am4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLL7PWAw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445805aa2eso28611885ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756509081; x=1757113881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqQqLaFsps1wVaocAvoqbMPJ7LhYdPmq7DHWmVRwav8=;
        b=MLL7PWAwE03B5l7S9gFpZ8Fpu4AqYBhrrXJVXL5hnmevwb/mDHct+ZKFisHbVGvvWF
         9S4AlmduwQMJToEFV+KsgMCzO6lqBX1VlPdLxyj9HnEIE3vihGzq0ThvC+Du9wFxXCLf
         IkNMPWzxc9HXw4PkOY/vvIzY+jBvFFDQtdYM67k+nzwGp9EOG+1usCJRsu2hZPg9GFd2
         MELIYwapuiRtsXqkZwuZPOdxUzr2HJ0GGwA36XexLSRp+OjeEcfpMdw0B9Csc0+1nQxc
         XhXZJ8z91rTgji8nvLEyBVyVUcmZEAV7WrdlAQ3ARawi9KbeyyCWKWn212UZuJ4Sx3Z7
         nk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756509081; x=1757113881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqQqLaFsps1wVaocAvoqbMPJ7LhYdPmq7DHWmVRwav8=;
        b=RIIqAaAZUkiymVnKn/rY1JDqYtBSZJEvcZ8b+8CmWs6fq2EggDfTeEQniensdaTBcW
         6cTjGcBA0yt7LmNzpLvNP7KiC/NytLGzsejJs+/oI3yz/a9jBHwoO5sXdkBWpz2xlSFD
         HPXjbhUeMjIOMUeac67JHATXwVtMtyLhpRi/eO6xsRGZ8KWgJVw9gixzGN3vXEd685v4
         wUp+pCYfPFhLLGfsQbiuHmTd2Dluj+oNEU/ZGPC318kCbGEqKLGa3GHHDbpK1ca1JTxf
         wWygL2BSIXjkaZL+TFGWWLZiI04QeqCtMhWmPri1sWcwNRBDgFUX/VEo+Ty342pxNcFs
         anFA==
X-Forwarded-Encrypted: i=1; AJvYcCVtJ4Puz+XEaKDwo+Hc8nVzUoVCHROcZ6/JWc8iIXdw9gJV8o8wJbhRt6H6vc12c37gSBAVf60AF7M8TM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCvSRWlHCJC5Djtf1tflXf00XKelMvcLvRryHfkwiYbTYgoK9
	3N6WtX7JVsJhQLPmBAq9yEco/+0gFi7KoaAHB/AZQqF68B4eZDqY33ok
X-Gm-Gg: ASbGncshwEbeozKg+FRbvgr8byq2KGE2uWOYUkz8p9PQYRTpVHDioVe8mMRVNy4ocCy
	r69a8kGYMj5mHICLfse4Ooz4sow0pLb8slXBTcoUfkYX95kSVuWhTUbCs5QCTpR4DOn2QC94QoZ
	T+qP1hzQv5vz8KIqlGgO+vVpJ07D/cd1is2/9EZVrtVgu1dibv8YHdpxARkVu+2NJkXeybXsaPT
	S6ZpDAhljfRBUdimu8DTe2XHvuTc3IZNlr64Ypg7n4Ey0fJ8mlxiA+kmtBI6RidiZV22kMh+wY2
	3/wUYXxJ7tMLGUHFXmEZN9wkcKLVMoJ8F6xbDVuZcBz1b5LBgLjNrvVGCJIej36TDmc+dWECsrA
	GCJoeBYVZLu8HqdkVdGGZf776ecjuK7jwDZOYlz/n6UBBf6gto67EEHArksrjshar
X-Google-Smtp-Source: AGHT+IF709aZ3IbIL2k4n/R5rHQNX2g9ksg2sYhPpZgYz9Wa4/J4YZRAVYsKytfiMLpEGoPVPVyovA==
X-Received: by 2002:a17:903:284:b0:249:40cb:a704 with SMTP id d9443c01a7336-249448e3de4mr3030985ad.15.1756509081452;
        Fri, 29 Aug 2025 16:11:21 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490373eb17sm35355625ad.54.2025.08.29.16.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:11:21 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:11:18 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 04/12] include/fs.h: add `const` to several pointer
 parameters
Message-ID: <aLIzlpOQ2uMVDpjQ@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-5-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-5-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:51PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

