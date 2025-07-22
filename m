Return-Path: <linux-kernel+bounces-741522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B147B0E546
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D72A65BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DF2285CBF;
	Tue, 22 Jul 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSno36Qa"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3F284671
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218810; cv=none; b=tQBfINg8RKP6lYAlgStskVoX+S1kocqZhRvYkQl5F5sqOr9DTKvyusNPV0j22wIs78V5MlAitDCfuorop6xHRixPJozos0C4Hn72CMqiws60o5PGlGYLpbSd9mFyppNEiFKymlTr1RWc18qBmsTwXtkHMITmB1lHYFgTsriM+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218810; c=relaxed/simple;
	bh=wwtrBXB8ibdKB9j/9CK69Unzz1v754W/g/0KbLp9gUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa3sHN/pFkHCDo1VprFPX3YQZ4x0eiZMQob8JAfRng0RJ8Krm0VjFAcMjXCe8ENhr3NgsiDo4/UioJTWpm4I5q7bc6aZ+jsMt/MYfSbR/I8MmqKIyWJzwW2GuZmKLgc6N4Q/6X5sIfxRJSh5ZVKCsHcIXY0o46rC1FCkL7Sqmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSno36Qa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0d7b32322so934446966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753218807; x=1753823607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwtrBXB8ibdKB9j/9CK69Unzz1v754W/g/0KbLp9gUk=;
        b=eSno36Qa3GuMRyAjvBEE+pT2o38yjJwqrGafq08aeeShpRUyDuHxPboVohLYzjSd2H
         J/AaOZxWBkw9t4SY3dkdQcXi08dgU7LQ/fsx4TSgxINBXXZG4m00pCUlg2Mcmktmi1O7
         kA22wx/brOGRbJBILH2TDTaJUobfM4qYX3xqTkUE/nE5XBlJC11hraqi+nLzDX4jc6Lb
         fhHrNBL2uVXrcG8hIaNW/QNxoePz+tyw9udu7yw5Rb1OAjJKSWbjrAfGElVos9oAkEyY
         Sg54fIZvv1dUU9mOl/pAlZMFqHOrz3RYHnIY+9qc/snhjj5QH3BZGCQz+fHZdsudcH/v
         e/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753218807; x=1753823607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwtrBXB8ibdKB9j/9CK69Unzz1v754W/g/0KbLp9gUk=;
        b=IfJNVMhWay8UHZoIAnvEabGOCG4rxNBnBR5HjYnkxH5CcIstwWvoD2BpJxllg5l3bt
         +Eu21dxZG80n20xWp2IeZ/t0rmEXnfrZqGh/rAx126GKjdegEgQUbsOHAQPENWqT+PkE
         Zfl7Zaix32HYatp2ad/kYeJkzAAA6A7bOZC4Izo1xMUzpMqqsluMKdi8nIV2ZE5tiaQj
         33VmeCnbwokJJXF/zMv7DE/VdigY0ASULWNcT9RbETF8dcjlV6WkfBg4XocoLLoBq1c7
         CdePtw0YMvX2VrtgnaPgHumY4Rfp8q3/mvjyuWj28MSuVr25cfst1P7l0nwhd4ssK3pV
         ULmg==
X-Forwarded-Encrypted: i=1; AJvYcCXhf+XiX/y6T8ZWc+G0IKxaljE4pjDWQiA99U49mvFlEDiqNb4BomxQwCP63Oqm8aJ+DfJ8Xdagt2W6Cv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAc2BFQ7kvPEYG1jLTMrCIEIGxDGx6w983EPbWnFmiHyFm5ApS
	8E9UF6RWjN9ftDSEyCW4kic/BoRIc4sYaXGva6qvrk6sMd2FLdO3i8blLm7wj304tT9CVxLiPNK
	me7b/jnViD3xHfzzIZqVBh31fMLTX2SbiWhzlqC6P
X-Gm-Gg: ASbGncvG0saNDW7FEq+YFiBrYIY/m6sTm9XYCyju/iag//lWHcuEe18f03JLl6h8207
	dxTs8Wh/YgTX4OOhz2vWBa/nhGS9KElNy+1LjFXUqXsUsI7DapX/b/zuDjECutNXcZ/BTUJtnuE
	Et4qQ+ZX2kK1sjaEKKB+QbGpjYMa7kGHhVCsbG8ilHwltllkUhLsVE6dYWburhLkje2zc+96Bj+
	gQ7M9K7Ong/iCpKyRVJ5W00dXizBCTlpHpZsQ==
X-Google-Smtp-Source: AGHT+IF5iBrnA8CeAarmrMD8sUm+LoqhPEoPIWqIjWp4bVEDDdpvi4LGDveeODjmd4nDrr5KgGyrFJwaPFEhL7HILko=
X-Received: by 2002:a17:907:f495:b0:ae0:a351:61ff with SMTP id
 a640c23a62f3a-af2f8958839mr32587966b.32.1753218807216; Tue, 22 Jul 2025
 14:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
 <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
 <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com> <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com>
From: Paul Lawrence <paullawrence@google.com>
Date: Tue, 22 Jul 2025 14:13:12 -0700
X-Gm-Features: Ac12FXwWHePEdBXlsbRDL14Rr96ybs6aO4nXPAOMeK8mNkU7e_cKPTHWYDa_QOk
Message-ID: <CAL=UVf5W9eJF4FL6aRG4e1VoFWg8jj4X4af=j-OGdU=QxmPuwA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

I spent a little time with these patches. I wrote my own to set the
backing file at lookup time by adding an optional second out struct.
Is there a reason we should not do this? It seems the most natural
solution.

After a while, I began to wonder if what I was planning was actually
the same as your vision. I decided to jot down my thoughts to see if
you agree with them. Also I was confused as to why you were adding the
ability to set backing files to GETATTR. So here are my notes.

Design of fuse passthrough for all operations

Goal:

When a fuse filesystem implements a stacking filesystem over an
underlying file system, and a significant fraction of the calls will
simply be passed to the underlying file system, provide a mechanism to
pass those calls through without going to user space. This is
primarily to enhance performance, though it might simplify the daemon
somewhat too.

Current state:

Currently passthrough allows a backing file to be set at file open
time. If a backing file is set, all read/write operations will be
forwarded to the backing file.

Design:

Add ability to set backing file on the found inode in response to a
positive lookup. This file might be opened with O_PATH for performance
reasons. The lookup api would be modified to have an optional second
out struct that contains the backing file id. Note that we will use
the backing file ioctl to create this id to remove any security
concerns.

The ioctl will also take a 64-bit integer to define which operations
will be passed through, the operations mask. This will have one bit
for each of the existing FUSE_OPERATIONS, at least the ones that act
on inodes/files.

Then when fuse fs is considering calling out to the daemon with an
opcode, fuse fs will check if the inode has a backing file and mask.
If it does, and the specific opcode bit is set, fuse fs will instead
call out to a kernel function in backing.c that can perform that
operation on the backing file correctly.

Details:

Question: Will it be possible to change the mask/backing file after
the initial setting? My feeling is that it might well be useful to be
able to set the mask, the file not so much. Situations would be (for
example) a caching file system that turns off read forwarding once the
whole file is downloaded.

FUSE_OPEN will, if the backing file has been set, reopen it as a file
(not a path) if needed. This is whether or not FUSE_OPEN is passed
through.

If FUSE_OPEN is passed through, user space will not get the chance to
assign a file handle ID to the opened file. It will still be possible
to pass FUSE_READ etc to the daemon - the daemon will still have the
node id and be able to read data based on that.

FUSE_LOOKUP can return a 0 node id, but only if *all* operations on
that node as marked as passthrough.

Suggestion: During FUSE_LOOKUP, if FUSE_GETATTR is set in the mask,
ignore the passed in attributes and read them from the backing file.

Random, non-exhastive list of considerations:

FUSE_FORGET can only be marked passthrough if the node id is 0.

FUSE_CREATE returns a new node id and file handle. It would need the
ability to set backing files.

If FUSE_LOOKUP is marked for passthrough, then looked up inodes will
be prepopulated with a backing O_PATH file and a mask will all bits
set.

FUSE_RENAME takes two nodes and names, and moves one to the other. If
one is passthrough and one is not, there is no obvious way of
performing a rename. Either fall back to copy/delete or return EXDEV

