Return-Path: <linux-kernel+bounces-862078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D1BF4609
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A7B18A6209
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A1274B40;
	Tue, 21 Oct 2025 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJZl8czZ"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205111D799D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013530; cv=none; b=UQB/Qb6ATlnIbnavjzxY7sZKylnU7d4HjN3XqZ+x8HjrO2TPech0YsuMp4jhY72kq0gEZujr5sv3eGksSum5QqKKPhExU1Ipkxd2vzxnmsEvQ7CAlqilrceNHosN8brCRrzYD9ExhG8M3gAJJTSYlqromoYtBhUwY+KITlfgy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013530; c=relaxed/simple;
	bh=4NEB6i79j5sz/k1jyryWLeGzpc1E3YymDL8QTIYQ8Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXfcPCMGQHwJMl+Qd4pzVapM1IiGkEXpcOohWeXnLjOzWduCTTDWxKj7mNoq5SPYlPgqJoWeExVotw8Igv82ImFq+8oe2nCqWxA05l3WiBgp9oapqzmbNImCfbY+H8bidox/W0xetGEw95T7IPkIwC1uc3HpAAD0fAdV43DtCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJZl8czZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-87c1ceac7d7so78348356d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761013527; x=1761618327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1luQ+e/4qugKBcMlsVj8SRUT2PF8Mxc4nYmeeDlrs0=;
        b=SJZl8czZWyQ2t48YqhUwGcjad94ymGoAksYYm9Cz53cOSOieCy1+1QOBq3WZa8/hgc
         l9wTpYPdpbbddFnDZ8LfG9fqMXQaar8i4gvYk1JkuuSWsAYYTq8RVScevPxex0//rsFP
         i6ESOeKp6oPEFdTqV9NlmfUWutnVlbFtvsYLskR9AE19ixkAJpe/HNIFfu4J1w8uaNyF
         H1kd/WN2roIMF3+S0xJO4Nho2yuLUijb67H/f8khjHjUF3XofnFS7fenrVt2N2Pw5Bte
         iBTLaZaVFRFe9PdfWbEN+SOF9I58eAAcTQX7wudiPEYCnCx4yTouBe4Kwn/9PBYBvwh6
         2S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761013527; x=1761618327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1luQ+e/4qugKBcMlsVj8SRUT2PF8Mxc4nYmeeDlrs0=;
        b=lt5o3Z6oK8bp3JkR6RrhjbJmAaQQSg/QoLnYR6MV0r5kt+fckg7sJ5B5qLM0H5V5ws
         PBpRSkpTV0sdOKiYDRRnBd/0VvYwA6bC7EtBNAGuOXgo7IXrTyVQ6wmo0Z5cKVASCFd5
         aY4Fxs8rbKVkv6kRB0bN1bauHRJoy3aqFEPSnLuXT77s+oY4a3yUwCkmAcdCRPCTb6q+
         FAulKKJkoyblfmnd26R2QAS7N08AaCsuGzb7SwfPg4yhnmHvsc4csPhJZY1akV1tCWt/
         xaxFmRCpHoGL8Z0WK+2mXfdBNSLE4AutU2fqIj5Psn58q4OLWOHZkkfaRG0CkG4FXaWL
         IpWw==
X-Forwarded-Encrypted: i=1; AJvYcCV43jmFmrlkUwWmA1kmdvYtjK7Y8yaunq60Hb9XXJQePj1QMCXK8RqxWNflqU8jLN+iuylENT9AinDNcN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8DtnTd3suYKq13lpyO60Km8fZtQ2KTe52nU4KzwAsARpyrqj
	23tOKup3TfohLOoOPfMuX6zRMQMq8NUgt7X77MRzY1Gl/iTW7txLz6EkjWHjmtgHDeVwGsvjFSl
	GOKUMaxs3HErZ3BSWO9L99ZRXz7RbqVQ=
X-Gm-Gg: ASbGncu5QjHq6DN8MWpTDS4J1u1E4oVAhuivaLh0ilO9RbLReevMkSbm9YeX0+Avzp0
	yXCz8kALo/jdKZ2RiiTlcdlYDLYBaH2wYiV/9qg4JfdvEujPBV6hiay7JBG2c9R1AvCGViczx+O
	Azo7IUTU1+ha76K0qCI/enq0txB9rlYQxWwguw2PpUP539EAofwt8Vd98oM+Qi+Wmd1OQnet9fI
	j9fXK2HtQKgKDxAoHbS5vTH+Fww59UPK35fGA+FUhBxuCvAXyBCnnCnHrVpoUKJYXONh9YKNk3d
	t6rIFBnD5WS6xRxv6G5Axu5KTJjK9g6yDQcdwuLGzOp/Zi4yuZjovJyxbHwPEihGzE5hSmyVc+a
	6gblsxI8tseIOz0TNM+DiuhTieyhPYzIQllaZkmH4cbPHR0GLbPLvGqkqniN7MKj9rcg6X4+X2h
	ESuGmV3qeFlg==
X-Google-Smtp-Source: AGHT+IGIbBXPdleJFTf9ZI3LepzrcCiGQHq4dOORSjB1wDA83bUwKlG+/bNzG6X1SQNa3QuvIrMxyseeEKUyTeKz8mA=
X-Received: by 2002:ad4:5cc1:0:b0:70d:6df4:1b21 with SMTP id
 6a1803df08f44-87c206475dcmr196922176d6.62.1761013527425; Mon, 20 Oct 2025
 19:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1090391.1760961375@warthog.procyon.org.uk> <jf5k4w47cw3jhc3nfmhwtaqtqxrqd5ufg4agpagacbxejyuhb7@udi3ed54kf3m>
In-Reply-To: <jf5k4w47cw3jhc3nfmhwtaqtqxrqd5ufg4agpagacbxejyuhb7@udi3ed54kf3m>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Oct 2025 21:25:16 -0500
X-Gm-Features: AS18NWAAU4F7DEiGyGYzXbDuBaEUTQIiuw45LKz1Aml1lgSpmTq63XNit4imBxM
Message-ID: <CAH2r5mvT9RtFAxLb0UCreeyfMMzhGU2BMO1FronmtQv+pQ8L4A@mail.gmail.com>
Subject: Re: [PATCH] cifs: Call the calc_signature functions directly
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged updated patch into cifs-2.6.git for-next (and also has Enzo Acked-by=
 now)

On Mon, Oct 20, 2025 at 8:39=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de>=
 wrote:
>
> Hi David,
>
> On 10/20, David Howells wrote:
> >As the SMB1 and SMB2/3 calc_signature functions are called from separate
> >sign and verify paths, just call them directly rather than using a funct=
ion
> >pointer.  The SMB3 calc_signature then jumps to the SMB2 variant if
> >necessary.
> >
> >Signed-off-by: David Howells <dhowells@redhat.com>
> >cc: Steve French <sfrench@samba.org>
> >cc: Paulo Alcantara <pc@manguebit.org>
> >cc: linux-cifs@vger.kernel.org
> >cc: linux-fsdevel@vger.kernel.org
> >---
> > fs/smb/client/cifsglob.h      |    2 --
> > fs/smb/client/smb2ops.c       |    4 ----
> > fs/smb/client/smb2proto.h     |    6 ------
> > fs/smb/client/smb2transport.c |   18 +++++++++---------
> > 4 files changed, 9 insertions(+), 21 deletions(-)
> >
> >diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> >index b91397dbb6aa..7297f0f01cb3 100644
> >--- a/fs/smb/client/cifsglob.h
> >+++ b/fs/smb/client/cifsglob.h
> >@@ -536,8 +536,6 @@ struct smb_version_operations {
> >       void (*new_lease_key)(struct cifs_fid *);
> >       int (*generate_signingkey)(struct cifs_ses *ses,
> >                                  struct TCP_Server_Info *server);
> >-      int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *=
,
> >-                              bool allocate_crypto);
> >       int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
> >                            struct cifsFileInfo *src_file);
> >       int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *t=
con,
> >diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> >index 7c392cf5940b..66eee3440df6 100644
> >--- a/fs/smb/client/smb2ops.c
> >+++ b/fs/smb/client/smb2ops.c
> >@@ -5446,7 +5446,6 @@ struct smb_version_operations smb20_operations =3D=
 {
> >       .get_lease_key =3D smb2_get_lease_key,
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >-      .calc_signature =3D smb2_calc_signature,
> >       .is_read_op =3D smb2_is_read_op,
> >       .set_oplock_level =3D smb2_set_oplock_level,
> >       .create_lease_buf =3D smb2_create_lease_buf,
> >@@ -5550,7 +5549,6 @@ struct smb_version_operations smb21_operations =3D=
 {
> >       .get_lease_key =3D smb2_get_lease_key,
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >-      .calc_signature =3D smb2_calc_signature,
> >       .is_read_op =3D smb21_is_read_op,
> >       .set_oplock_level =3D smb21_set_oplock_level,
> >       .create_lease_buf =3D smb2_create_lease_buf,
> >@@ -5660,7 +5658,6 @@ struct smb_version_operations smb30_operations =3D=
 {
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >       .generate_signingkey =3D generate_smb30signingkey,
> >-      .calc_signature =3D smb3_calc_signature,
> >       .set_integrity  =3D smb3_set_integrity,
> >       .is_read_op =3D smb21_is_read_op,
> >       .set_oplock_level =3D smb3_set_oplock_level,
> >@@ -5777,7 +5774,6 @@ struct smb_version_operations smb311_operations =
=3D {
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >       .generate_signingkey =3D generate_smb311signingkey,
> >-      .calc_signature =3D smb3_calc_signature,
> >       .set_integrity  =3D smb3_set_integrity,
> >       .is_read_op =3D smb21_is_read_op,
> >       .set_oplock_level =3D smb3_set_oplock_level,
> >diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
> >index b3f1398c9f79..7e98fbe7bf33 100644
> >--- a/fs/smb/client/smb2proto.h
> >+++ b/fs/smb/client/smb2proto.h
> >@@ -39,12 +39,6 @@ extern struct mid_q_entry *smb2_setup_async_request(
> >                       struct TCP_Server_Info *server, struct smb_rqst *=
rqst);
> > extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *ser=
ver,
> >                                               __u64 ses_id, __u32  tid)=
;
> >-extern int smb2_calc_signature(struct smb_rqst *rqst,
> >-                              struct TCP_Server_Info *server,
> >-                              bool allocate_crypto);
> >-extern int smb3_calc_signature(struct smb_rqst *rqst,
> >-                              struct TCP_Server_Info *server,
> >-                              bool allocate_crypto);
> > extern void smb2_echo_request(struct work_struct *work);
> > extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
> > extern bool smb2_is_valid_oplock_break(char *buffer,
> >diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport=
.c
> >index 33f33013b392..916c131d763d 100644
> >--- a/fs/smb/client/smb2transport.c
> >+++ b/fs/smb/client/smb2transport.c
> >@@ -247,9 +247,9 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, _=
_u64 ses_id, __u32  tid)
> >       return tcon;
> > }
> >
> >-int
> >+static int
> > smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serv=
er,
> >-                      bool allocate_crypto)
> >+                  bool allocate_crypto)
> > {
> >       int rc;
> >       unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
> >@@ -576,9 +576,9 @@ generate_smb311signingkey(struct cifs_ses *ses,
> >       return generate_smb3signingkey(ses, server, &triplet);
> > }
> >
> >-int
> >+static int
> > smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serv=
er,
> >-                      bool allocate_crypto)
> >+                  bool allocate_crypto)
> > {
> >       int rc;
> >       unsigned char smb3_signature[SMB2_CMACAES_SIZE];
> >@@ -589,6 +589,9 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TC=
P_Server_Info *server,
> >       struct smb_rqst drqst;
> >       u8 key[SMB3_SIGN_KEY_SIZE];
> >
> >+      if ((server->vals->protocol_id & 0xf00) =3D=3D 0x200)
>
> Please use:
>
>    if (server->vals->protocol_id <=3D SMB21_PROT_ID)
>
> Other than that
>
> Acked-by: Enzo Matsumiya <ematsumiya@suse.de>
>
> >+              return smb2_calc_signature(rqst, server, allocate_crypto)=
;
> >+
> >       rc =3D smb3_get_sign_key(le64_to_cpu(shdr->SessionId), server, ke=
y);
> >       if (unlikely(rc)) {
> >               cifs_server_dbg(FYI, "%s: Could not get signing key\n", _=
_func__);
> >@@ -657,7 +660,6 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TC=
P_Server_Info *server,
> > static int
> > smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
> > {
> >-      int rc =3D 0;
> >       struct smb2_hdr *shdr;
> >       struct smb2_sess_setup_req *ssr;
> >       bool is_binding;
> >@@ -684,9 +686,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Ser=
ver_Info *server)
> >               return 0;
> >       }
> >
> >-      rc =3D server->ops->calc_signature(rqst, server, false);
> >-
> >-      return rc;
> >+      return smb3_calc_signature(rqst, server, false);
> > }
> >
> > int
> >@@ -722,7 +722,7 @@ smb2_verify_signature(struct smb_rqst *rqst, struct =
TCP_Server_Info *server)
> >
> >       memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
> >
> >-      rc =3D server->ops->calc_signature(rqst, server, true);
> >+      rc =3D smb3_calc_signature(rqst, server, true);
> >
> >       if (rc)
> >               return rc;
> >
> >
>


--=20
Thanks,

Steve

