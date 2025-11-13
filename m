Return-Path: <linux-kernel+bounces-899051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 595B3C56A16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFEEB347EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CB335573;
	Thu, 13 Nov 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUcBbNlf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lyfYf5uG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929533507B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026497; cv=none; b=YWFR6B1btPfFNxEP2RHXCqepOS8MesW9vleBfEoSrj6dh2znN+wInJ5Am3O9OjtPbmASEQIBtwpKLN/4lVU6vtTSX9WbdQLANTlmBDXptsd7DLBdliwJGNleL7Tt4cmZPY1QZEzoA8I48C6SnpOI9ZX/YXZ0g4r5z9/tGOW96Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026497; c=relaxed/simple;
	bh=PsMX5azptoPCiLjD3aMiz5hio74WlY1qb2dfxYCfrpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8arXDBzobSRB+dMRoDn1hNLEByrHk6k7iUGkFy1MNt+KnVncLGHJCZAyfE5JBUDS0bBMZH9n3EUE9Je6LwN+Edw+pO7mroFCCKs1TM2rz9zjHJ1ymeRrJvtKJUnlfU09kB+SdMPrkqMTC2ne5I5tLrwgIH2ZUhCOA7CYeUzzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUcBbNlf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lyfYf5uG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmEXxMQNcr7Ao680eVcUDXmbzW6uxx+W3/652jHTtt8=;
	b=cUcBbNlfySIZV0Q3oArfFjXFHuyOgqUlbrnbxx7G9BTlqZatmvXBjcw/JknYKExNV9yK8N
	CqZCUVlKUQ3XODENM8NF9ncZEo4wgwXVI0Y2ckWfcjhFULrDnTMqCCR4csnl0kSgBtETql
	tK6Iok2zJ0uwuXQ45Di1n8m9mrzCWBc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-P8ReM7_aOdO_w0hNG0fJcw-1; Thu, 13 Nov 2025 04:34:53 -0500
X-MC-Unique: P8ReM7_aOdO_w0hNG0fJcw-1
X-Mimecast-MFC-AGG-ID: P8ReM7_aOdO_w0hNG0fJcw_1763026493
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso464959f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026492; x=1763631292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmEXxMQNcr7Ao680eVcUDXmbzW6uxx+W3/652jHTtt8=;
        b=lyfYf5uGu84oVlVmmikVDFBhwRkp5q/ZlNP3bUE3OL5hsJ1jl6bpJ9gh8U/gkUvcGu
         CzL/VzEWS7atnvpxi6zPsjcvDMqlgXDQenytQLsvdlk6lIa/ZPNCDyubZ7s+tfWJtVz4
         fZFUfPGT0brwsbRGeOB/hrcS9ZbnONhRU8Agu4eG72p9PxQL1vPuLnuRpW9BFwC+5kYD
         MFF1ahDlW6b6rbUE+FVr9eohLy8tlQxjvuNFlzim9wDLl7oDOXySlLPdIg4Nd0AcaARA
         KFPjgmw1nphPBWStnBfWCIh+JHVuYp2moyxfow4p3Ve11gaMDjEl26ifLUCW5wkxHgk3
         kIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026492; x=1763631292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmEXxMQNcr7Ao680eVcUDXmbzW6uxx+W3/652jHTtt8=;
        b=D7ePNEqe+j363eVp/lLszbOH0vi0nA/0kqVFwy4fiaSdDZiYEWOx/h7i4xWzx89dd6
         g4RrtJ2cJVBdL41uBZ1qOn7gZiLk46TLWQlGQ/1beozLvi93gleVBls8QR6V5Eb6cny/
         VFvc97dGAKx/y14nAY5lmdavETBpeKEviWUXbpgKfL4W1avjXJTuTWi6ODtwwoMfDnWi
         5McFuGK/6WJtqFSW/a0qM6ElgY3v7eOCCP93qJpukwuBBK2dZbAPOKTphjb9ZRnbnzjw
         oCQoINLCp4or/yM7eLhu76pUsdjAArYTa0SvDxQycLRs7Akc8tiatyYXUkXV5qEtrK2l
         xNwA==
X-Gm-Message-State: AOJu0Yy1yrdeHObW3rfI4sA4Uxu7vvf5cuH+vgkxcRiKwIqvfHIcFZhC
	iCChhzrIxTGNRvy5IjrW2uAifpxpq4gazPSGhSaUYvh1v4ys58XqrY5x1yxvW8pyrVk1PJd9d72
	zO5rn4zJfEt0WklXZbqmjxajhY+pne0dSzk3Joi3IpcTsUTFGlqD+X+TC66daSyoNmUokCS9aHL
	Sk69vdVMU9+E3ztsx8ZIUxTadvgzuBLkCjjif7BhTrEGUq3w==
X-Gm-Gg: ASbGncvnxFcFXxccBP7+DSm3ujo1srSH8HtToxtqq+GytjdC3Li+3lFed4aW32LFsyQ
	TOQc7dFCHt13B+bvpnNI8/67AXEVz/j/GXlfewvMTapizdj1XC2J9Ob15UfZSpyKqUhXjT+ikhq
	nLJYRbASSFgc0+zX/fmpqt204haZGhm/4uWi/lIeo+WH2AeJlh+bS7Epw9PfoKU1rKpai5wR9J4
	pmVaQ0RDPPgPQZwATEYwr+5V+g7vBN5DLpYAiH5iRfT9FbDjQ4m5sxCrOpbHrQ23EOukAvMeQLh
	/jLlL0tQou1JAS/dm9qj2N6jPW7sF90qAsBA84fILBoq3x390BtXDoP+z/REt2YEBuouE8J/dGD
	NEyqDfp035tD/WH5P3JY=
X-Received: by 2002:a05:600c:19c7:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-477870c5352mr55490945e9.19.1763026492386;
        Thu, 13 Nov 2025 01:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1jtRWVnrdLUlv4C9KrYAs72euPMIvvFiYX1nC4u6hRuLMPr91T8iFR0bzArS1Cipzq/HwXQ==
X-Received: by 2002:a05:600c:19c7:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-477870c5352mr55490545e9.19.1763026491858;
        Thu, 13 Nov 2025 01:34:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7aea7sm2724783f8f.1.2025.11.13.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:51 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 8/8] virtio: fix map ops comment
Message-ID: <f6ff1c7aff8401900bf362007d7fb52dfdb6a15b.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

@free will free the map handle not sync it. Fix the doc to match.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 1a019a1f168d..a1af2676bbe6 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -177,7 +177,7 @@ struct virtio_config_ops {
  *      map: metadata for performing mapping
  *      size: the size of the buffer
  *      vaddr: virtual address of the buffer
- *      map_handle: the mapping address to sync
+ *      map_handle: the mapping address that needs to be freed
  *      attrs: unmapping attributes
  * @need_sync: if the buffer needs synchronization
  *      map: metadata for performing mapping
-- 
MST


