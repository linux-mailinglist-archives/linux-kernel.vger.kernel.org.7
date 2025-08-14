Return-Path: <linux-kernel+bounces-769032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7FEB2696A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6523B607583
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3135B1D5165;
	Thu, 14 Aug 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pyVUXcru"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446F194C75
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180920; cv=none; b=AdM/F+bFo/3aXK35e0VGYkF20sRjkGTX5sK4qmiNqjUIOu0gqq3JEgsb8/67KbxqWeF7ZburCl0BKe/qbXR8TDkNEtZhJxmYNcqCHwrATLttjQVfCJ7O8jAzmFQE3IAA+5CbbRmzS/6nvHASrwbnPZlKQqBaB6IhQVYlTrOnAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180920; c=relaxed/simple;
	bh=O2fCO0OXYh2U2UzVT5Rqs0xFhq+/i6HnjmVP2jE+V4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxl1t0gVBQ5cleE7wLF9myPnyUoisIhJtI5y3VTnlEeujT2o59qRkQFThRThi6K88UvavN+XTxdG4aoGThyX/pIZlekhG/8eFqAdRYlOH/tQ35J7YigLpoMC/tJQVxaugI2VI1NdUn3vBm3gXdG5NFyzUAVS0pCZ0ojKW+QJQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pyVUXcru; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b1098f9e9eso13627271cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755180915; x=1755785715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BUQkPCyVmoncxak/Y7aRi7IQhlbH4GfyrdWoO6ES88=;
        b=pyVUXcruvgKF1jBKlp6e4xfIUllOqW5gAOBcCg+n9SOKWDO4LIMfAgwWS7GJkXau2P
         2J2/ZD5I+JJ7xANsJTUe+QfrJyJieIBPkHSNHgXwNCtkjsjsqr0KiwXDs0EYqYO8h4sR
         prPs91MESYdck74m0hQBMZx0aKoeXDGnsEuD90aFcTqGALK2qmc1Bi6RsibwpWjNbJ44
         Uxhm4GsPbPSRMfgT5gW0l4N6AygNXJw7ChKOCbvqrjshHtfn41mbWrSPAbm2bxZLXOEU
         SvvImGbny6RbTUIBLdrJNUZvtTfQiJAaaEY/6xxuNPDUEdE9l4pxaCN/gOA+w6Wat8f8
         QeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180915; x=1755785715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BUQkPCyVmoncxak/Y7aRi7IQhlbH4GfyrdWoO6ES88=;
        b=Rgly1aIIbJNXkYcB8tXnI0POJ0QB63uW8pMuqK9R9xvp+eyQ1HDvKTWGcuCE1E4Vb0
         SpugMcV22Q/yNquh1tP+NaodYtzdeGFLVl6/PjTuXUBjWki2CNE6DL+0JvNkkyieXitp
         lfmVodWgaRw8LK5qTh5b0VMUlRwnhCMhEz8W3SbPlDHE+c8/n4grabJMuT4zW/0WXLju
         mVxR6KM6PcQV/yz2KvRcOBkOZk0fZnOWqRNTDs1BHcXFjl//efBJPyTyAfN4ImRyJ1yi
         PPtx7NLA/Xet6vqZFh3YvFsmt/iCh1Nuu6PetHPCOPcWLvTjcO+UmbXhg2lNb9f4yzkI
         0Hgg==
X-Forwarded-Encrypted: i=1; AJvYcCWOZLsOL1B/G/n5jXkylA+fucu3NCeHDUOfsVENlvJSEW08lL63I9okXA78xHH2nm4i5pMHSpGm6Y2DW9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+h1q7DgE7hboQUsiQgooffoaRgMHLmpGTY8ZaFm1Wo0gYv3D
	VqvZyngl/xrtWON58jE/nVDLTmOF7VmLay4ZUM2EbdidPMpLLdznwms3hjAdnP5YhuU=
X-Gm-Gg: ASbGncvKe6coRCYhiUMQa3JhhsLecLZK4hC2rk9rhspWG7G5sJWjiPDJKNnynkUC8yx
	A1R1z/hQerYPle5D/wUXwbNUD0Z478E4maSgrJjyRPOZLHWG5eQis+ANaCwpP21m8yZQw7qmzGN
	nA60GdKrSxsGu7RjwzdC6Vak3RHxf6J0ZIud9+bzlEno15VxQUl5Rlw42MlPJ14vi2TKLlQimVI
	e3AzukKy2tvdxbc/vA+x2PyqDqvYCtgmKvdsFfgokHM+48771hlEh8T0P/0xmqsqTrMzZ3Z9Wuh
	fyfcjwai32C+tTsoDSsWrXx6opabffJh7Ra0wpW4jnUFsI8XlMcdhqYFeb6fcgyMYUPrPG21GNP
	U7hsqv5qOYVwYAcVEz9wyxrVB0zNBNYnd
X-Google-Smtp-Source: AGHT+IF9dyhnIQhWpXCycIJ6xPTYoImLg+4fKfvhwrB8MgdBLjKixENuSwgcpdo7nZyGKshdy3C1yA==
X-Received: by 2002:a05:622a:1ccc:b0:4b1:dd3:e3a1 with SMTP id d75a77b69052e-4b10dd3ee68mr26844041cf.64.1755180914955;
        Thu, 14 Aug 2025 07:15:14 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b06a86735asm155735351cf.31.2025.08.14.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:15:14 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:15:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/show_mem: Print totalreserve_pages in show_mem output
Message-ID: <20250814141513.GG115258@cmpxchg.org>
References: <20250814092622.24535-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814092622.24535-1-ye.liu@linux.dev>

On Thu, Aug 14, 2025 at 05:26:21PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Add totalreserve_pages to the main show_mem output line for easier
> debugging and memory analysis. This helps developers and
> administrators quickly see how many pages are reserved by the kernel
> and not available for user allocations.

This number isn't used very widely in decision making.

For actual allocations, what matters is watermarks, lowmem_reserve,
highatomic, and cma pages - all of which are already printed out on a
per-zone basis in show_mem().

