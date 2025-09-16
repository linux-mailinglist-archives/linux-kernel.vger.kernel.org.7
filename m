Return-Path: <linux-kernel+bounces-819654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584EEB5A420
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4A41BC1A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA02DF3FD;
	Tue, 16 Sep 2025 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="dPWRx+0l"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D6285CA1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059141; cv=none; b=QI+IhbDEHSwAiHhHBANaEPalZCYy3teIkc847EBjwhaycX29+g1RXR6sDJipnHJ3HZ8KHNdI4WgsuhngIWVPSd5UUFE3X/lBGCLWIfFr4MsBgHbd/bVTXBZgQUM38dLT7KeFT8d5N9670NZ81JECefgQwvpmRBJO3gpKHRSfjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059141; c=relaxed/simple;
	bh=2oMu80/8qr3zTmEJZAl1KXHqB5S4PD4PrukmUZoG8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L45IIisgkA1jqbj7zFkV+AI3VHYo/XoXi4AKhh6U78kWUYEP6fUhNdaxGN3K9Lz7DAfEfTSuhOmDTnk4Z2pGrW0NSbAIwsrzl93Ynx9YzJvQeXRybN266mV0AndapDDMWr6iwWKwRYHcV68xqv3d0GmR2Tubp/lWEAiVUC5D7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=dPWRx+0l; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso5313852a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758059139; x=1758663939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oMu80/8qr3zTmEJZAl1KXHqB5S4PD4PrukmUZoG8ms=;
        b=dPWRx+0lJ63wnaT0oGGWF9dQpCl2vFIQ9fgLeR0YNaN12g9JM5xAw9bR+HKVt/LHuv
         b0ni1E1OHJ+q1/DDwHMPsjdn/X4x3BPhQRHaurDsARgEs806xs/sgdc2BjRjHnNZaT67
         jOaYyZeTkUq9mZP4fOkxLpsJXdhRsZDwTJo9a6JTcwlS6v4AdZTJV16+DnlbbqFIlr2h
         5k2XuKwCgrXaXyApbbXxLlAGz0Jze3PV8IMCarms4l7lnJ517MjCQ//C4Pyd9ytVq4Cf
         nmsdu5cBl+MQjoyOoQLHMZ4GujY7K0gQn6SW0UvVwK1R8IyzpxyH/TfNa1De3ApG6c8S
         eqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059139; x=1758663939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oMu80/8qr3zTmEJZAl1KXHqB5S4PD4PrukmUZoG8ms=;
        b=IobrP+O1kEGwawh7hH7CtLbGiuEB1rTZuFJbIl/0XKe27rebLQATrMZwyQWnVQV6vB
         2cNJJ3qjYaWSsy0i0SJcmnd3GdsDPMMdQSLZZxOXONv839WlQ3DQT7sBuj4sFoOcVvnD
         tUiIOtlFtY3k+UUZ88DtEsnM7bPaClVppJnfQ1BRaZZSbdH2vdZRIKX+ZvGkP0B8sQJ5
         bmwSjFgLapEiDnKONHN0o8qQadV4mUsWKtGKupY/TYTD6D82LnZwJuJuBzsqGp/km41f
         w4UYqvRBnrj5J0zOfXPSXZc8oU/CWAuAKXaGIrdVwRrhJvFKaB/4b7Xsb+m8SnFExnF9
         6GmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeTukBioBAl9O34ugbzQtPBvW/aGzv9TDisAt1fm4GGEAvc/xbcl05rRqyWzWTFiVGIp90QnvOhO71sMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb785JLuOT+fTwzjzIisNXr+h8CboKDoeI3pXsD9HSVnhefOpi
	oqXGWF18yitpPWsakF5xwfW6chprwlkkB0Rs6V89+TZTUMe2x2Z0OAmlwzr9u80U/WORBImdRU9
	smLsU
X-Gm-Gg: ASbGncuWAAzVvcZ1ahHBBj+GRyhoQ7zkWXYRANNMLEh3bTZwKpPGYUiRm2DK13sPQfG
	f+iTNbkoYFfm4QaDYh+LuiuAwNmq+9RFE3zAv4AB/yjtcUpxTs0pq/HCYvQu6i/OccLtqhhXURm
	kit/M9Og8uA6KOWhET6WpU0HqmrwWkQ0CS4VHwxLafkomIEbzpk2PBuMStpsVjptsIKOxd7Du8b
	NFRgV+2/q/qzNi/3w6f4P2Z9OKNuXpTHAYHrxx/J/OFGz7I62zNMUgYkDajwJRk/ZparbyIVirA
	3H2fViKgrhcd+sUkwd4tha/c6u3nsqS5yDq1sE011Zl/gNDYvwoJTKAzWP2KqB3Z01jqSq79y5L
	3Ey5N8DqInNRZ6U5D+LIYsJ6ok8YYRwMI
X-Google-Smtp-Source: AGHT+IF5/A9g/gHD57+H8Ivg3g3/IAIPeuIqDTP9P2EseS5E1C+rm4rMi/1Yy80FsS4n3Id30lQozg==
X-Received: by 2002:a17:903:1ab0:b0:24c:d08e:309b with SMTP id d9443c01a7336-25d24cac50fmr187714865ad.15.1758059138768;
        Tue, 16 Sep 2025 14:45:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed266eed7sm530003a91.3.2025.09.16.14.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:45:38 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:45:35 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V12 4/5] riscv: mm: Add soft-dirty page tracking support
Message-ID: <aMnaf_3tInUXbuTb@debug.ba.rivosinc.com>
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
 <20250915101343.1449546-5-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250915101343.1449546-5-zhangchunyan@iscas.ac.cn>

On Mon, Sep 15, 2025 at 06:13:42PM +0800, Chunyan Zhang wrote:
>The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
>for software, this patch uses bit 59 for soft-dirty.
>
>To add swap PTE soft-dirty tracking, we borrow bit 3 which is available
>for swap PTEs on RISC-V systems.
>
>Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

Reviewed-by: Deepak Gupta <debug@rivosinc.com>
>---

