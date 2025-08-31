Return-Path: <linux-kernel+bounces-793553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0377B3D515
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE523A773C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457F239E7E;
	Sun, 31 Aug 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS8LM6Br"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9ED22F76F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756670826; cv=none; b=hFfLO9jboRPeoF63UZOuICUN9+NDne23i7cpzfh+ghd6cXUnPXbwIaOPDIvPky4VhG0SPNd1dlIavM2Y98d99cP/iNAxU3ubWIdydS0qFPjKZGTHVrlckCDVHHMMkPCXYCPzy5hSw7xuP1jvDbrmqL+EdowwmnaDTOFpjVP/Uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756670826; c=relaxed/simple;
	bh=wsnQHQtOjEsrk5LwzayKHsCA53X5jYtCABISMzMGcpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTIB6l/ZUSBSPl4cdPFvldWWZFu6mivN4M8Jdmwv0ZUvBVIxSczHP+3HW9NSrEP51+/uA3y5C0uhRWnFae0CKAzhNpdsOfImDW0lMYOlVJwoD1mC71VL/GyrXPC4qvpr8FHgvyS//IRZwk0LpCg0X62AE8qX0uRNghKKiKc1CsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS8LM6Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30524C4CEF5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756670826;
	bh=wsnQHQtOjEsrk5LwzayKHsCA53X5jYtCABISMzMGcpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MS8LM6Brjp3YWCX6+0c7otTaxb9ewRKJ3502T+vaFkPzThUGd3n23tlgj8iFbtQeI
	 oQcBBlO4sbGq9ksfwWjUJWV9BNLJ7TFkNVp6+G81ThOSz7oj4IC9b6y6YvlGVY0lpn
	 4fJNgOUtr2lamLh08xY3SusSDz+OJoUCBt12to59Qie7g9Qf9XllySPSxP9JY6nESi
	 5x7uQKuLeZRmFO71B+4RzB2DDKt/KpsEl5DTQj50eTrtrMbBN7Fhrzb57yggDKKNxr
	 tC/WJEWT3rS+uNG3kGNYRdHx3qh8Wyi5NBI5E7fhCbgG1IWZk6WJrFVGG6loD5UUmG
	 gGXwjn1gnWagQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60157747so28091657b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 13:07:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAANYO4smxhcleZ/DBgrqVDig/ewteMCK40/4UmN56I/um4s4UrWNNmHrCBWeZl1ecfrFwsJI14pVOWjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHV9bmsYzkQfpm44Zkj5rf62HGIMMBbOItddADPyKZfnBZZbP
	kOPBK0azozhacq5KR7pCsLi+GavpPwy7OrikJ/9DZDcJ1M0QWj7D6NUcvYpvzGknZcxkDwc3uui
	BKDtg5zR3Vcu6tcwgfmxx47gCvnYq5n9p3LnEglB0DA==
X-Google-Smtp-Source: AGHT+IG3GaqCHReEFS8Kk0O0HYcyQ3az2zl3VkJpMwaXeWGUAfnqR1acr2/2mqUAcOK53WHBMmNZ7sBWNWn2cZcW6zA=
X-Received: by 2002:a05:690c:6704:b0:720:378:bed6 with SMTP id
 00721157ae682-7227655f628mr72942507b3.41.1756670825451; Sun, 31 Aug 2025
 13:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-8-ryncsn@gmail.com>
 <CACePvbXB-G5vhoEt87BZcjDZ8kZWo3mZtAZ60YbR_gcjnPz29w@mail.gmail.com>
 <CAMgjq7Aznd7=m6JTNGM4EyFj+6pqHTRBCo2hsQL-cKi0LZggOg@mail.gmail.com> <CAMgjq7AdauQ8=X0zeih2r21QoV=-WWj1hyBxLWRzq74n-C=-Ng@mail.gmail.com>
In-Reply-To: <CAMgjq7AdauQ8=X0zeih2r21QoV=-WWj1hyBxLWRzq74n-C=-Ng@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 31 Aug 2025 13:06:54 -0700
X-Gmail-Original-Message-ID: <CACePvbVJY9x05nW_jWd4PWox972OqMxi=YFP_wGbjHzXFyvY5Q@mail.gmail.com>
X-Gm-Features: Ac12FXzteZ0lmimyc9FHu-eqbCwqH9k6tlWXgsNJCJjhM-DO2tVOgzinsSJIxmQ
Message-ID: <CACePvbVJY9x05nW_jWd4PWox972OqMxi=YFP_wGbjHzXFyvY5Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm, swap: remove contention workaround for swap cache
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 8:55=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> So I tried to run some HDD test for many rounds, basically doing the
> test in the URL below manually. Test is done using nr_task =3D 8. The
> HDD swap partition size is 8G.
>
> Do the preparation following:
> https://github.com/intel/lkp-tests/blob/master/setup/swapin_setup
> (Make usemem hold 8G memory and push them to swap)
>
> And do the test with:
> https://github.com/intel/lkp-tests/blob/master/programs/swapin/run
> (Use SIGUSR1 to make usemem to read its memory and swapin)
>
> Before this patch:
> Test run 1:
> 1073741824 bytes / 878662493 usecs =3D 1193 KB/s
> 33019 usecs to free memory
> 1073741824 bytes / 891315681 usecs =3D 1176 KB/s
> 35144 usecs to free memory
> 1073741824 bytes / 898801090 usecs =3D 1166 KB/s
> 36305 usecs to free memory
> 1073741824 bytes / 925899753 usecs =3D 1132 KB/s
> 20498 usecs to free memory
> 1073741824 bytes / 927522592 usecs =3D 1130 KB/s
> 34397 usecs to free memory
> 1073741824 bytes / 928164994 usecs =3D 1129 KB/s
> 35908 usecs to free memory
> 1073741824 bytes / 929890294 usecs =3D 1127 KB/s
> 35014 usecs to free memory
> 1073741824 bytes / 929997808 usecs =3D 1127 KB/s
> 30491 usecs to free memory
> test done
>
> Test run 2:
> 1073741824 bytes / 771932432 usecs =3D 1358 KB/s
> 31194 usecs to free memory
> 1073741824 bytes / 788739551 usecs =3D 1329 KB/s
> 25714 usecs to free memory
> 1073741824 bytes / 795853979 usecs =3D 1317 KB/s
> 33809 usecs to free memory
> 1073741824 bytes / 798019211 usecs =3D 1313 KB/s
> 32019 usecs to free memory
> 1073741824 bytes / 798771141 usecs =3D 1312 KB/s
> 31689 usecs to free memory
> 1073741824 bytes / 800384757 usecs =3D 1310 KB/s
> 32622 usecs to free memory
> 1073741824 bytes / 800822764 usecs =3D 1309 KB/s
> 1073741824 bytes / 800882227 usecs =3D 1309 KB/s
> 32789 usecs to free memory
> 30577 usecs to free memory
> test done
>
> Test run 3:
> 1073741824 bytes / 775202370 usecs =3D 1352 KB/s
> 31832 usecs to free memory
> 1073741824 bytes / 777618372 usecs =3D 1348 KB/s
> 30172 usecs to free memory
> 1073741824 bytes / 778180006 usecs =3D 1347 KB/s
> 32482 usecs to free memory
> 1073741824 bytes / 778521023 usecs =3D 1346 KB/s
> 30188 usecs to free memory
> 1073741824 bytes / 779207791 usecs =3D 1345 KB/s
> 29364 usecs to free memory
> 1073741824 bytes / 780753200 usecs =3D 1343 KB/s
> 29860 usecs to free memory
> 1073741824 bytes / 781078362 usecs =3D 1342 KB/s
> 30449 usecs to free memory
> 1073741824 bytes / 781224993 usecs =3D 1342 KB/s
> 19557 usecs to free memory
> test done
>
>
> After this patch:
> Test run 1:
> 1073741824 bytes / 569803736 usecs =3D 1840 KB/s
> 29032 usecs to free memory
> 1073741824 bytes / 573718349 usecs =3D 1827 KB/s
> 30399 usecs to free memory
> 1073741824 bytes / 592070142 usecs =3D 1771 KB/s
> 31896 usecs to free memory
> 1073741824 bytes / 593484694 usecs =3D 1766 KB/s
> 30650 usecs to free memory
> 1073741824 bytes / 596693866 usecs =3D 1757 KB/s
> 31582 usecs to free memory
> 1073741824 bytes / 597359263 usecs =3D 1755 KB/s
> 26436 usecs to free memory
> 1073741824 bytes / 598339187 usecs =3D 1752 KB/s
> 30697 usecs to free memory
> 1073741824 bytes / 598674138 usecs =3D 1751 KB/s
> 29791 usecs to free memory
> test done
>
> Test run 2:
> 1073741824 bytes / 578821803 usecs =3D 1811 KB/s
> 28433 usecs to free memory
> 1073741824 bytes / 584262760 usecs =3D 1794 KB/s
> 28565 usecs to free memory
> 1073741824 bytes / 586118970 usecs =3D 1789 KB/s
> 27365 usecs to free memory
> 1073741824 bytes / 589159154 usecs =3D 1779 KB/s
> 42645 usecs to free memory
> 1073741824 bytes / 593487980 usecs =3D 1766 KB/s
> 28684 usecs to free memory
> 1073741824 bytes / 606025290 usecs =3D 1730 KB/s
> 28974 usecs to free memory
> 1073741824 bytes / 607547362 usecs =3D 1725 KB/s
> 33221 usecs to free memory
> 1073741824 bytes / 607882511 usecs =3D 1724 KB/s
> 31393 usecs to free memory
> test done
>
> Test run 3:
> 1073741824 bytes / 487637856 usecs =3D 2150 KB/s
> 28022 usecs to free memory
> 1073741824 bytes / 491211037 usecs =3D 2134 KB/s
> 28229 usecs to free memory
> 1073741824 bytes / 527698561 usecs =3D 1987 KB/s
> 30265 usecs to free memory
> 1073741824 bytes / 531719920 usecs =3D 1972 KB/s
> 30373 usecs to free memory
> 1073741824 bytes / 532555758 usecs =3D 1968 KB/s
> 30019 usecs to free memory
> 1073741824 bytes / 532942789 usecs =3D 1967 KB/s
> 29354 usecs to free memory
> 1073741824 bytes / 540793872 usecs =3D 1938 KB/s
> 32703 usecs to free memory
> 1073741824 bytes / 541343777 usecs =3D 1936 KB/s
> 33428 usecs to free memory
> test done
>
> It seems to match the ~33% swapin.throughput regression reported by
> the bot, it's about ~40% faster with this patch applied. I'll add this
> test result to V2.

Oh, wow you do have the HDD number, congrates. Now we can make the
claim with numbers.
I hope you did not cripple a HDD to get that number.

Thanks.

Chris

